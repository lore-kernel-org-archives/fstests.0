Received: from imap.thunk.org ([74.207.234.97]:40534 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeIAWzp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 1 Sep 2018 18:55:45 -0400
Date: Sat, 1 Sep 2018 14:42:45 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: problem with tune2fs after ext4 godown
Message-ID: <20180901184245.GB25570@thunk.org>
References: <1513324055-77618-1-git-send-email-cgxu519@icloud.com>
 <1513324055-77618-3-git-send-email-cgxu519@icloud.com>
 <CAOQ4uxgf=btK-MKed7-8_nmpfO-UnPyVJ4RyTtK1hMQuU8Y=-g@mail.gmail.com>
 <63598ea1-8fd3-1003-a5b1-cb177a9380d8@gmx.com>
 <6c2125c0-5a89-4a67-7a2c-2bebe8dd5b7e@gmx.com>
 <CAOQ4uxhu9rNBByXwZifcf=mmDekGwu8H4s8GsMrFMcanp-7A5Q@mail.gmail.com>
 <92bd7ae7-3601-9682-d131-258500393e9b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92bd7ae7-3601-9682-d131-258500393e9b@gmx.com>
Sender: fstests-owner@vger.kernel.org
To: cgxu519 <cgxu519@gmx.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Chengguang Xu <cgxu519@icloud.com>, Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>, Ext4 <linux-ext4@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 31, 2018 at 10:53:54PM +0800, cgxu519 wrote:
> steps to reproduce:
> 
> 1) mount an ext4 fs
> 2) write a file in the fs
> 3) sync / or do nothing
> 4) running godown tool in xfstest to the fs
> 5) umount the fs
> 6) mount the fs
> 7) tune2fs -l <dev>
> 
> tune2fs -l will fail with below error.
> 
> [root@x201 xfstests-dev]# tune2fs -l /dev/mapper/test-test1
> tune2fs 1.44.2 (14-May-2018)
> tune2fs: Superblock checksum does not match superblock while trying to
> open /dev/mapper/test-test1
> Couldn't find valid filesystem superblock.
> 
> NOTE, I don't know this is a real issue or just by design.

It's a real issue, thanks.  The fix is below:

					- Ted

>From 4274f516d4bc50648a4d97e4f67ecbd7b65cde4a Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 1 Sep 2018 14:42:14 -0400
Subject: [PATCH] ext4: recalucate superblock checksum after updating free
 blocks/inodes

When mounting the superblock, ext4_fill_super() calculates the free
blocks and free inodes and stores them in the superblock.  It's not
strictly necessary, since we don't use them any more, but it's nice to
keep them roughly aligned to reality.

Since it's not critical for file system correctness, the code doesn't
call ext4_commit_super().  The problem is that it's in
ext4_commit_super() that we recalculate the superblock checksum.  So
if we're not going to call ext4_commit_super(), we need to call
ext4_superblock_csum_set() to make sure the superblock checksum is
consistent.

Most of the time, this doesn't matter, since we end up calling
ext4_commit_super() very soon thereafter, and definitely by the time
the file system is unmounted.  However, it doesn't work in this
sequence:

mke2fs -Fq -t ext4 /dev/vdc 128M
mount /dev/vdc /vdc
cp xfstests/git-versions /vdc
godown /vdc
umount /vdc
mount /dev/vdc
tune2fs -l /dev/vdc

With this commit, the "tune2fs -l" no longer fails.

Reported-by: Chengguang Xu <cgxu519@gmx.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
---
 fs/ext4/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f7750bc5b85a..e41da553b430 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4378,11 +4378,13 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	block = ext4_count_free_clusters(sb);
 	ext4_free_blocks_count_set(sbi->s_es, 
 				   EXT4_C2B(sbi, block));
+	ext4_superblock_csum_set(sb);
 	err = percpu_counter_init(&sbi->s_freeclusters_counter, block,
 				  GFP_KERNEL);
 	if (!err) {
 		unsigned long freei = ext4_count_free_inodes(sb);
 		sbi->s_es->s_free_inodes_count = cpu_to_le32(freei);
+		ext4_superblock_csum_set(sb);
 		err = percpu_counter_init(&sbi->s_freeinodes_counter, freei,
 					  GFP_KERNEL);
 	}
-- 
2.18.0.rc0
