import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State var selectedItem : [PhotosPickerItem] = []
    @State var data : Data?
    
    var body: some View {
        VStack {
            
            // Eğer gerçekten data'da bir şey varsa
            if let data = data {
                // Elde ettiğimiz datadan görsel oluşturup view'a ekliyoruz.
                if let selectedImage = UIImage(data: data) {
                    Spacer()
                    Image(uiImage: selectedImage)
                        .resizable()
                        .frame(width: 300, height: 300, alignment: .center)
                }
            }
            Spacer()
            
            // PhotosPicker kullanımı bu kadar, tek satır kodla galeriden istediğimizi seçtirebiliyoruz.
            PhotosPicker(selection: $selectedItem, maxSelectionCount: 1, matching: .images) { 
                Text("Select Image")
                    .padding()
            }.onChange(of: selectedItem) { newValue in
                guard let item = selectedItem.first else {
                    return // Burada seçilen görseli alıyoruz.
                }
                // loadTransferable ile aldığımız görseli data'ya çeviriyoruz.
                item.loadTransferable(type: Data.self) { result in
                    switch result{
                    case .success(let data):
                        if let data = data {
                            self.data = data // Seçilen görsel data oldu.
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
        }
    }
}
