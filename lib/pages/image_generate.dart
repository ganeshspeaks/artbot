import 'package:ArtBot/components/buy_subscription_dialog.dart';
import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';

class ImageGenerate extends StatefulWidget {
  const ImageGenerate({super.key});

  @override
  State<ImageGenerate> createState() => _ImageGenerateState();
}

enum ImageSize{
  size256,
  size512,
  size1024,
}

class _ImageGenerateState extends State<ImageGenerate> {
  final textController = TextEditingController();
  Future<OpenAIImageModel>? future;
  String url = '';

  // default image size
  ImageSize defaultImageSize = ImageSize.size512;

  // default image style
  String? selectedStyle;

  // // default image size
  // ImageSize? selectedSize;

  int freeCredits = 4; 


  Future<void> createAIImage() async{
    OpenAI.apiKey = 'YOUR_API_KEY';
    if(textController.text.trim().isNotEmpty){
      OpenAIImageModel image = await OpenAI.instance.image.create(
          prompt: textController.text,
          n: 1,
          size: OpenAIImageSize.size512,
          responseFormat: OpenAIImageResponseFormat.url,
        );

        setState(() {
          future = Future.value(image);
        });
    }
  }

  Map<String, String> styleMap = {
    'No style':';',
    'tattoo design':'Tattoo drawing style:',
    'pencil art':'Pencil drawing style:',
    'natural':'Natural style:'
  };

  OpenAIImageSize getImageSize(ImageSize size){
    switch (size){
      case ImageSize.size256:
        return OpenAIImageSize.size256;
      case ImageSize.size512:
        return OpenAIImageSize.size512;
      case ImageSize.size1024:
        return OpenAIImageSize.size1024;
      default:
        throw ArgumentError('Unsupported ImageSize: $size');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArtBot'),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin:const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    margin: const EdgeInsets.all(10),
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        width: 5.0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLines: 3,
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: 'Type here a detailed description of what you want to see in your artwork...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey[700],
                          ),
                          contentPadding: const EdgeInsets.only(left: 8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                              
                  // image style dropdown
                  Container(
                    padding:const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Center(
                      child: DropdownButton<String>(
                        
                        underline: Container(),
                        alignment: AlignmentDirectional.center,
                        value: selectedStyle,
                        hint: const Text('Style'),
                        onChanged: (String? newValue) {
                          selectedStyle = newValue!;
                          textController.text = styleMap[newValue]!;
                        },
                        items: styleMap.keys.map((String style) {
                          return DropdownMenuItem<String>(
                            value: style,
                            child: Text(style),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
              
                  // generate button
                  Container(
                    width: double.infinity,
                    padding:const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child:TextButton(
                      onPressed: (){
                        // createAIImage();

                        setState(() {
                          freeCredits -=1;
                        });

                        if(freeCredits <=0){
                          showDialog(
                            context: context, 
                            builder: (context){
                              return const BuySubscriptionDialog();
                            }
                          );
                        }else if(freeCredits > 0){
                          createAIImage();
                        }
                      },
                      child:const Text(
                        '  Generate  ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Text(
                    freeCredits <=0 ? '0 Credits' : '$freeCredits Credits',
                  ),

                  const SizedBox(height: 20,),
                ],
              ),
            ),

            FutureBuilder<OpenAIImageModel>(
              future: future, 
              builder:(context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                } else if(snapshot.hasError){
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } else if(snapshot.hasData){
                  url = snapshot.data!.data[0].url.toString();
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration:const BoxDecoration(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          url,
                        ),
                      ),
                    ),
                  );
                } else{
                  return  Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: [Color.fromARGB(255, 1, 60, 148), Color.fromARGB(255, 106, 21, 14)],
                        ).createShader(bounds);
                      },
                      child:const Icon(
                        Icons.star_border_rounded,
                        size: 200,
                      ),
                    ),
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}