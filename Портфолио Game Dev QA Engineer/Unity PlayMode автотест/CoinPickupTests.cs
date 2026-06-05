using System.Collections;
using NUnit.Framework;
using UnityEngine;
using UnityEngine.TestTools;
using UnityEngine.SceneManagement;

public class CoinPickupTests
{
    private GameObject player;
    private GameObject coin;
    private PlayerInventory playerInventory;
    private int initialCoins;
    private Vector3 initialPlayerPosition;

    [UnitySetUp]
    public IEnumerator SetUp()
    {
        yield return SceneManager.LoadSceneAsync("LevelTemplate");
        yield return null;

        player = GameObject.FindGameObjectWithTag("Player");
        Assert.IsNotNull(player, "Игрок не найден!");

        coin = GameObject.FindGameObjectWithTag("Coin");
        Assert.IsNotNull(coin, "Монетка не найдена!");

        playerInventory = player.GetComponent<PlayerInventory>();
        Assert.IsNotNull(playerInventory, "PlayerInventory не найден!");

        initialCoins = playerInventory._coinsCount;
        initialPlayerPosition = player.transform.position;
    }

    [UnityTest]
    public IEnumerator PickUpCoin_WhenPlayerCollides_CoinDestroyedAndScoreIncremented()
    {
        // Перемещаем монетку к игроку
        coin.transform.position = player.transform.position + Vector3.up * 0.5f;

        // Ждём два кадра, чтобы физика точно отработала
        yield return null;
        yield return null;

        // ПРОВЕРКА 1: монетка уничтожена (игровой объект стал null)
        // Используем прямое сравнение, чтобы избежать бага NUnit
        Assert.IsTrue(coin == null, "Монетка не была уничтожена!");

        // ПРОВЕРКА 2: количество монет увеличилось на 1
        int newCoins = playerInventory._coinsCount;
        Assert.AreEqual(initialCoins + 1, newCoins,
            $"Было {initialCoins}, стало {newCoins}");
    }

    [UnityTearDown]
    public IEnumerator TearDown()
    {
        if (player != null)
            player.transform.position = initialPlayerPosition;
        yield return null;
    }
}