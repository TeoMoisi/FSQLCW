# Instructions to run the project:

1. Open Eclipse in Java view mode
2. Press import project -> Git -> Projects from Git -> Clone URI -> input 'https://github.com/TeoMoisi/FSQLCW.git'
3. Select only the master branch (everything needed is there)
![SelectMaster](https://user-images.githubusercontent.com/34157782/114608236-238ed700-9ca6-11eb-975a-7b0de841fd79.png)

4. Select all the folders from the branch:

![Screenshot 2021-04-13 at 21 55 49](https://user-images.githubusercontent.com/34157782/114608261-2b4e7b80-9ca6-11eb-928e-b091ca62f40b.png)

5. Wait until the project has been cloned and build
6. In the beginning, there will be some errors, but the most of them will dissapear after Generating the artifacts.
Go to FSQL.xtext file and:
![GenerateArtifacts](https://user-images.githubusercontent.com/34157782/114608296-36091080-9ca6-11eb-8251-06fbd9893d7f.png)


7. The only errors that will be related to some missing directories, namely src and xtend-gen, in uk.ac.kcl.language.fsql.ui.tests. Create them and the errors will be gone.

![TestErrors](https://user-images.githubusercontent.com/34157782/114608360-491be080-9ca6-11eb-8944-822c70a51cfb.png)
![MissingFolders](https://user-images.githubusercontent.com/34157782/114608408-546f0c00-9ca6-11eb-9752-9df29f2daee1.png)

9. Run the project as Eclipse Application and wait for the runtime eclipse to open.

![Screenshot 2021-04-13 at 21 48 26](https://user-images.githubusercontent.com/34157782/114608447-5e910a80-9ca6-11eb-80cd-fb189285d1e4.png)

11. In order to add the editor and xpect tests folders:
    - go to File -> Open Projects from File System

    ![Screenshot 2021-04-13 at 21 50 52](https://user-images.githubusercontent.com/34157782/114608476-66e94580-9ca6-11eb-9d2e-f142f249bcf8.png)

    - select the directory in which you cloned the project
    - then select FSQLTest and uk.ac.kcl.language.fsql.xpect folders

    ![Screenshot 2021-04-13 at 21 55 49](https://user-images.githubusercontent.com/34157782/114608544-78cae880-9ca6-11eb-8e12-3ee709d44726.png)

    - you can now freely try out the language and run the xpect tests
