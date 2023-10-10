//
//  ContentView.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 9/10/23.
//



import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("BackgroundSkySpy")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()  // Empuja el área de la imagen hacia abajo
                
                // Área para la imagen en la parte inferior
                ZStack {
                    RoundedRectangle(cornerRadius: 30)  // Marcos
                        .fill(Color.white)  // Fondo blanco
                        .frame(height: 400)  // Ajusta la altura según lo necesites
                        
                    RoundedRectangle(cornerRadius: 30)  // Borde
                        .stroke(lineWidth: 8)
                        .frame(height: 400)  // Ajusta la altura según lo necesites
                        .foregroundColor(.gray)
                    
                    /*Image("Pendiente!!")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)  // Asegúrate de que la altura coincida con la altura del marco*/
                }
                .padding(30)  // Añade un poco de espacio alrededor del área de la imagen
            }
        }
    }
}


#Preview {
    ContentView()
}
