package com.ada.web2.config;

import com.ada.web2.model.Filme;
import com.ada.web2.repository.FilmeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Component
public class DataLoader implements CommandLineRunner {

    @Autowired
    private FilmeRepository filmeRepository;

    @Override
    public void run(String... args) throws Exception {
        // Verifica se já existem dados no banco
        if (filmeRepository.count() == 0) {
            carregarDadosIniciais();
        }
    }

    private void carregarDadosIniciais() {
        List<Filme> filmes = Arrays.asList(
                new Filme(null, "Matrix", "Lana Wachowski, Lilly Wachowski", 1999,
                         "Ficção Científica",
                         "Um hacker descobre a verdade chocante sobre sua realidade e seu papel na guerra contra seus controladores.",
                         8.7, 136),

                new Filme(null, "O Poderoso Chefão", "Francis Ford Coppola", 1972,
                         "Crime/Drama",
                         "O patriarca idoso de uma dinastia do crime organizado transfere o controle de seu império clandestino para seu filho relutante.",
                         9.2, 175),

                new Filme(null, "Pulp Fiction", "Quentin Tarantino", 1994,
                         "Crime/Drama",
                         "As vidas de dois assassinos da máfia, um boxeador, a esposa de um gângster e dois bandidos se entrelaçam em quatro histórias de violência e redenção.",
                         8.9, 154),

                new Filme(null, "Forrest Gump", "Robert Zemeckis", 1994,
                         "Drama/Romance",
                         "As presidências de Kennedy e Johnson, a Guerra do Vietnã e outros eventos se desenrolam através da perspectiva de um homem do Alabama com um QI de 75.",
                         8.8, 142),

                new Filme(null, "A Origem", "Christopher Nolan", 2010,
                         "Ficção Científica/Ação",
                         "Um ladrão que rouba segredos corporativos através do uso da tecnologia de compartilhamento de sonhos recebe a tarefa inversa de plantar uma ideia na mente de um CEO.",
                         8.8, 148),

                new Filme(null, "Interestelar", "Christopher Nolan", 2014,
                         "Ficção Científica/Drama",
                         "Uma equipe de exploradores viaja através de um buraco de minhoca no espaço em uma tentativa de garantir a sobrevivência da humanidade.",
                         8.6, 169),

                new Filme(null, "Parasita", "Bong Joon-ho", 2019,
                         "Thriller/Drama",
                         "Ganância e discriminação de classe ameaçam a relação simbiótica recém-formada entre a rica família Park e o clã indigente de Kim.",
                         8.5, 132),

                new Filme(null, "O Senhor dos Anéis: A Sociedade do Anel", "Peter Jackson", 2001,
                         "Fantasia/Aventura",
                         "Um manso hobbit do Condado e oito companheiros partem em uma jornada para destruir o poderoso Um Anel e salvar a Terra-média do Senhor do Escuro Sauron.",
                         8.8, 178),

                new Filme(null, "Clube da Luta", "David Fincher", 1999,
                         "Drama",
                         "Um funcionário de escritório insone e um fabricante de sabão formam um clube de luta clandestino que evolui para algo muito mais.",
                         8.8, 139),

                new Filme(null, "Coringa", "Todd Phillips", 2019,
                         "Crime/Drama/Thriller",
                         "Em Gotham City, mentalmente perturbado, o comediante Arthur Fleck é desconsiderado e maltratado pela sociedade. Ele então embarca em uma espiral descendente de revolução e crime sangrento.",
                         8.4, 122)
        );

        filmeRepository.saveAll(filmes);
        System.out.println("✅ " + filmes.size() + " filmes de exemplo foram carregados no banco de dados!");
    }
}
