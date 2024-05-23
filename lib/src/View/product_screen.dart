import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../Constants/app_colors.dart';
import '../Controller/Notifier/product_notifier.dart';
ProductScreen()=>  ChangeNotifierProvider(create: (_)=>ProductNotifier(),child: Builder(builder: (context)=>ProductScreenProvider(context:context)),);
class ProductScreenProvider extends StatelessWidget {
   ProductScreenProvider({Key? key, required BuildContext context}) : super(key: key){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var state = Provider.of<ProductNotifier>(context, listen: false);
      state.initState();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ProductNotifier>(builder: (context, state, child) =>SafeArea(
      top: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
          children: [
          Expanded(
              child: TextFormField(
                controller: state.search,
                decoration: InputDecoration(contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: BorderSide(color: Colors.transparent),),filled:true,hintText: "Search",fillColor:Colors.white38,
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: BorderSide(color: Colors.grey)), suffixIcon:SvgPicture.asset('assets/images/svg/search.svg', height: 15, width: 15,),prefixIcon:  SvgPicture.asset('assets/images/svg/searchimage.svg',
                  height: 5, width: 5,)),
                onChanged: (value){state.searchProducts(value);
                  print("value${value}");},)),
               InkWell(onTap: (){
                  state.Showsorting();},
            child: SvgPicture.asset(
              'assets/images/svg/short.svg', height: 35, width: 35,
            ),
          ),],
      ),

          state.showshort ==false? Container():Container(
            width: 400,
            decoration: BoxDecoration(
             ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Short By`",),
                Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(5))),
              Divider(color: AppColors.gray,thickness: 2,),
                Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(15))),

                ListView.builder(
                  itemCount: state.sortmodel.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return InkWell(onTap: (){state.SelectItem(index);},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(state.sortmodel[index].title!),
                            SvgPicture.asset( state.sortmodel[index].isCheck==true?
                        'assets/images/svg/redio.svg':'assets/images/svg/rediocheck.svg',
                                height: 15, width: 15) ],),);}),],),),
          ),
            Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(15),
               )),
              Text("Category",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: AppColors.black),),
                      Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),),
            SizedBox(
        height: 60,
        child: ListView.builder(
            itemCount: state.myCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final category = state.myCategories[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    state.fetchCategorieProducts(category);
                  },
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: category == state.selectedCategory
                          ? AppColors.black
                          : AppColors.gray
                    ),
                    child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                              fontWeight: category == state.selectedCategory
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: category == state.selectedCategory? AppColors.white:AppColors.black,
                              fontSize: 18),
                        )),
                  ),
                ),
              );
            }),
      ),

       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Sumsung",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: AppColors.black)),
         // SvgPicture.asset("assets/images/svg/list.svg",height: 16,)
         InkWell(onTap: (){
           state.show();
         },
           child: state.showList==false?SvgPicture.asset(
             'assets/images/svg/list.svg',

             height: 35,
             width: 35,
           ):SvgPicture.asset(
             'assets/images/svg/grid.svg',
             height: 35,
             width: 35,
           ),
         ),
      ]),
         state.showList==false?
         Container(
        height: 700,
        child:
        GridView.builder(
          itemCount: state.productssearch.isEmpty?state.products.length:state.productssearch.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 1
          ),
          itemBuilder: (BuildContext context, int index){
            final product =state.productssearch.isEmpty? state.products[index]:state.productssearch[index];
            return   Stack(
              children:[
                Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Circular border
                  border: Border.all(
                    color: Colors.grey, // Optional: Add a border (adjust color as needed)
                    width: 1.0, // Optional: Adjust border width
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child:  Container(
                         // width: 200,

                          clipBehavior: Clip.antiAlias,
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.circular(15) // Adjust the radius as needed
                          ),
                          child: Image.network(
                            product['thumbnail'],width: 200,height: 400,
                            fit: BoxFit.cover                    ),
                        ),

                      ),
                  Text(product["title"]),
                  Text("\$${product['price']}"),
                  Flexible(
                    child: Text(product["description"],),
                  ),

                    ],
                  ),
                ),
              ),
                Positioned(
                    top:5,left:80,right:5,
                    child: Container(
                  height:35,
                  width: 50,

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppColors.black),child: const Center(child: Text("Bestseller",style: TextStyle(color: AppColors.white,fontSize: 14,fontWeight: FontWeight.w300),),),))

            ]);
          }
        )):

         Container(

       child:  ListView.builder(
         controller: state.scrollController,
         shrinkWrap: true,
           itemCount: state.productssearch.isEmpty?  state. products.length:state.productssearch.length,
           itemBuilder: (context,index){

             final product = state.productssearch.isEmpty?state.products[index]:state.productssearch[index];
             print("length${state.products.length}");

             return Stack(
               children:[ Padding(
                 padding: const EdgeInsets.only(top: 8.0),
                 child: Container(
                   height: 100,
                   //padding: EdgeInsets.all(10),
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: AppColors.gray,width: 2)
                   ),
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                           height: 150,
                           clipBehavior: Clip.antiAlias,
                           decoration:  BoxDecoration(
                               borderRadius: BorderRadius.circular(15) // Adjust the radius as needed
                           ),
                           child: Image.network(
                             product["thumbnail"],
                             fit: BoxFit.fill,
                           ),
                         ),
                       ),
                       Expanded(
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(product["title"],style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.black)),
                             Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(5))),
                             Expanded(child: Text(product["description"],style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.black,),textAlign: TextAlign.start,)),
                             Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(5))),
                             Text("\$${product['price']}",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.black)),
                           ],),
                       ),
                     ],),
                 ),
               ),
                 Positioned(
                     top:15,left:250,right:5,
                     child: Container(
                       height:30,
                       width: 0,
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppColors.black),child: const Center(child: Text("Bestseller",style: TextStyle(color: AppColors.white,fontSize: 14,fontWeight: FontWeight.w300),),),))
             ]);
             //return state.isLoadMore? Center(child: CircularProgressIndicator(),):Text("All data fetch");
           }
           ),),]),)),
        ),
    ),
    );
  }
}
