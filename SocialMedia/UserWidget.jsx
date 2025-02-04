import {
    ManageAccountsOutlined,
    EditOutlined,
    WorkOutlineOutlined,
  } from "@mui/icons-material";
  import { Box, Typography, Divider, useTheme } from "@mui/material";
  import UserImage from "components/UserImage";
  import FlexBetween from "components/FlexBetween";
  import WidgetWrapper from "components/WidgetWrapper";
  import { useSelector } from "react-redux";
  import { useEffect, useState } from "react";
  import { useNavigate } from "react-router-dom";
  
  const UserWidget = ({ userId, picturePath }) => {
    const [user, setUser] = useState(null);
    const { palette } = useTheme();
    const navigate = useNavigate();
    const token = useSelector((state) => state.token);
    const dark = palette.neutral.dark;
    const medium = palette.neutral.medium;
    const main = palette.neutral.main;
  
    const getUser = async () => {
      const response = await fetch(`http://localhost:3001/users/${userId}`, {
        method: "GET",
        headers: { Authorization: `Bearer ${token}` },
      });
      const data = await response.json();
      setUser(data);
    };
  
    useEffect(() => {
      getUser();
    }, []); // eslint-disable-line react-hooks/exhaustive-deps
  
    if (!user) {
      return null;
    }
  
    const {
      firstName,
      lastName,
      Bio,
      Fitness_Goal,
      Favourite_Activity,
      Age,
    } = user;
  
    return (
      <WidgetWrapper>
        {/* FIRST ROW */}
        <FlexBetween
          gap="0.5rem"
          pb="1.1rem"
          onClick={() => navigate(`/profile/${userId}`)}
        >
          <FlexBetween gap="1rem">
            <UserImage image={picturePath} />
            <Box>
              <Typography
                variant="h4"
                color={dark}
                fontWeight="500"
                sx={{
                  "&:hover": {
                    color: palette.primary.light,
                    cursor: "pointer",
                  },
                }}
              >
                {firstName} {lastName}
              </Typography>
            </Box>
          </FlexBetween>
          <ManageAccountsOutlined />
        </FlexBetween>
  
        <Divider />
  
        {/* SECOND ROW */}
        <Box p="1rem 0">
  {/* Bio */}
  <Box display="flex" alignItems="center" gap="1rem" mb="0.5rem">
    <Typography variant="h6">Bio:</Typography>
    <Typography>{Bio}</Typography>
  </Box>
  {/* Fitness Goal */}
  <Box display="flex" alignItems="center" gap="1rem" mb="0.5rem">
    <Typography variant="h6">Fitness Goal:</Typography>
    <Typography>{Fitness_Goal}</Typography>
  </Box>

  {/* Favourite Activity */}
  <Box display="flex" alignItems="center" gap="1rem" mb="0.5rem">
    <Typography variant="h6">Favourite Activity:</Typography>
    <Typography>{Favourite_Activity}</Typography>
  </Box>
  {/* Age */}
  <Box display="flex" alignItems="center" gap="1rem">
    <Typography variant="h6">Age:</Typography>
    <Typography>{Age}</Typography>
  </Box>
</Box>
</WidgetWrapper>
    );
  };
  
  export default UserWidget;
  