Received: from mx1.redhat.com ([209.132.183.28]:43376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733254AbfIFBTn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Sep 2019 21:19:43 -0400
Date: Fri, 6 Sep 2019 09:26:45 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic/43{0,1,2,3}: add -t option when create
 $testdir/copy file
Message-ID: <20190906012645.GE7239@dhcp-12-102.nay.redhat.com>
References: <20190905013921.13396-1-yin-jianhong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905013921.13396-1-yin-jianhong@163.com>
Sender: fstests-owner@vger.kernel.org
To: "Jianhong.Yin" <yin-jianhong@163.com>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com, jiyin@redhat.com
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 05, 2019 at 09:39:21AM +0800, Jianhong.Yin wrote:
> to avoid there's already a copy file before run test,
> it might break test.
> 
> I know now in xfs_io->copy_range there's a hidden truncate action
> to do that, but we are taking about remove it, see:
>  https://www.spinics.net/lists/linux-xfs/msg31292.html
>  https://www.spinics.net/lists/linux-xfs/msg31327.html
> 
> Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
> ---

Hi,

By checking the code logic of generic/430, I don't think it needs to truncate
the target file before copy_range. To make sure that, I did below test[1], then
nothing fails. I tested with upstream kernel and xfsprogs(with your patches). 

I didn't do more test than that, if I missed something please feel free to
tell me.

Thanks,
Zorro

[1]
# git am $your_patches
# git log --oneline
22c1ab98 (HEAD -> for-next) xfsprogs: copy_range: let = (src_size - src_offset) if len omitted
792d4bfb xfsprogs: copy_range don't truncate dstfile
...
# make -j8 && make -j8 install && make -j8 install-dev
# grep -rsnl copy_range tests/|grep -v .out
tests/generic/group
tests/generic/434
tests/generic/430
tests/generic/431
tests/generic/432
tests/generic/433
tests/generic/553
tests/generic/554
tests/generic/564
tests/generic/565
# ./check generic/430 generic/431 generic/432 generic/433 generic/434 generic/553 generic/554 generic/564 generic/565                                       
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 ibm-x3650m4-10 5.3.0-rc6-xfs-for-next #12 SMP Thu Sep 5 07:35:55 EDT 2019
MKFS_OPTIONS  -- -f -bsize=4096 /dev/mapper/xxx-xxx-xxxxx-xfscratch
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/xxx-xxx-xxxx-xfscratch /mnt/scratch                                                                              

generic/430 2s ...  2s
generic/431 3s ...  2s
generic/432 3s ...  3s
generic/433 2s ...  3s
generic/434      2s
generic/553      2s
generic/554      8s
generic/564      3s
generic/565      5s
Ran: generic/430 generic/431 generic/432 generic/433 generic/434 generic/553 generic/554 generic/564 generic/565                                                                              
Passed all 9 tests



>  tests/generic/430 | 2 +-
>  tests/generic/431 | 2 +-
>  tests/generic/432 | 2 +-
>  tests/generic/433 | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/430 b/tests/generic/430
> index 1b11f60d..71c6d438 100755
> --- a/tests/generic/430
> +++ b/tests/generic/430
> @@ -47,7 +47,7 @@ $XFS_IO_PROG -f -c 'pwrite -S 0x62 1000 1000' $testdir/file >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c 'pwrite -S 0x63 2000 1000' $testdir/file >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c 'pwrite -S 0x64 3000 1000' $testdir/file >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c 'pwrite -S 0x65 4000 1000' $testdir/file >> $seqres.full 2>&1
> -$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
> +$XFS_IO_PROG -t -f -c "copy_range $testdir/file" "$testdir/copy"
>  cmp $testdir/file $testdir/copy
>  echo "Original md5sums:"
>  md5sum $testdir/{file,copy} | _filter_test_dir
> diff --git a/tests/generic/431 b/tests/generic/431
> index f04ae215..4b22a8ff 100755
> --- a/tests/generic/431
> +++ b/tests/generic/431
> @@ -40,7 +40,7 @@ rm -f $seqres.full
>  
>  echo "Create the original file and then copy"
>  echo -n "abcde" > $testdir/file
> -$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
> +$XFS_IO_PROG -t -f -c "copy_range $testdir/file" "$testdir/copy"
>  echo -n "abcde" | cmp $testdir/copy
>  echo "Original md5sums:"
>  md5sum $testdir/{file,copy} | _filter_test_dir
> diff --git a/tests/generic/432 b/tests/generic/432
> index 6200af86..a2fecf37 100755
> --- a/tests/generic/432
> +++ b/tests/generic/432
> @@ -46,7 +46,7 @@ $XFS_IO_PROG -f -c 'pwrite -S 0x62 1000 1000' $testdir/file >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c 'pwrite -S 0x63 2000 1000' $testdir/file >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c 'pwrite -S 0x64 3000 1000' $testdir/file >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c 'pwrite -S 0x65 4000 1000' $testdir/file >> $seqres.full 2>&1
> -$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
> +$XFS_IO_PROG -t -f -c "copy_range $testdir/file" "$testdir/copy"
>  cmp $testdir/file  $testdir/copy
>  echo "Original md5sums:"
>  md5sum $testdir/{file,copy} | _filter_test_dir
> diff --git a/tests/generic/433 b/tests/generic/433
> index 1238419a..6204f339 100755
> --- a/tests/generic/433
> +++ b/tests/generic/433
> @@ -42,7 +42,7 @@ rm -f $seqres.full
>  
>  echo "Create the original file and then copy"
>  echo -n "abcde" > $testdir/file
> -$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
> +$XFS_IO_PROG -t -f -c "copy_range $testdir/file" "$testdir/copy"
>  cmp $testdir/file $testdir/copy
>  echo "Original md5sums:"
>  md5sum $testdir/{file,copy} | _filter_test_dir
> -- 
> 2.21.0
> 
