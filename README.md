`. make sure Federated-RL-ROS already exist
2. docker compose build -t ros_noetic
3. docker compose up -d
4. docker exec -it ros bash
5. open container
6. catkin_make
7. ``` source devel/setup.bash ```
8. permanent ``` echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc ```
