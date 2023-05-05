//
//  MeView.swift
//  HotProspects
//
//  Created by Tamim Khan on 5/5/23.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "your@site.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    
    var body: some View {
        NavigationView{
            Form{
                    TextField("Name", text: $name)
                        .textContentType(.name)
                        .font(.title)
                    
                    TextField("Email", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .font(.title)
                
                
                Image(uiImage: genarateQRCode(from: "\(name)\n\(emailAddress)"))
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            .navigationTitle("Your code")
        }
    }
    
    func genarateQRCode(from string: String) -> UIImage{
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage{
            if let cgImg = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgImg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
