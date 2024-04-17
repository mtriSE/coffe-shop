import { Card } from "flowbite-react";
import React from "react";

const RoomCard = () => {
  return (
    <Card
      className="max-w-sm"
      imgSrc="img/rooms/1.jpg"
      imgAlt="Room Image"
    >
      <h5 className="text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
        Phòng học 1
      </h5>
      <p className="font-normal text-gray-700 dark:text-gray-400">
        <strong>Mô tả</strong>
        <ul>
          <li>- Máy lạnh</li>
          <li>- Máy chiếu</li>
          <li>- ...</li>
        </ul>
      </p>
    </Card>
  );
};

export default RoomCard;
