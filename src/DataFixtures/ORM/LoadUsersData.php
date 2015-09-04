<?php
/**
 * Created by PhpStorm.
 * User: nickolay
 * Date: 7/16/15
 * Time: 8:04 PM
 */

namespace DataFixtures\ORM;


use Doctrine\Common\DataFixtures\FixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;
use Symfony\Component\DependencyInjection\ContainerAwareInterface;
use Symfony\Component\DependencyInjection\ContainerAwareTrait;

class LoadUsersData implements FixtureInterface, ContainerAwareInterface
{
    use ContainerAwareTrait;
    /**
     * Load data fixtures with the passed EntityManager
     *
     * @param ObjectManager $manager
     */
    public function load(ObjectManager $manager)
    {
        $manipulator = $this->container->get('fos_user.util.user_manipulator');
        $manipulator->create('admin', 'admin', 'admin@admin', true, true);
    }
}