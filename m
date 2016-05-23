Received: from mx1.redhat.com ([209.132.183.28]:57211 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111AbcEWHq4 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 23 May 2016 03:46:56 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42228C03BD56
	for <fstests@vger.kernel.org>; Mon, 23 May 2016 07:46:56 +0000 (UTC)
Date: Mon, 23 May 2016 15:46:54 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] xfs/106: rewrite this case for run it as auto test
 again
Message-ID: <20160523074654.GF5140@eguan.usersys.redhat.com>
References: <1463460110-15297-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463460110-15297-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On Tue, May 17, 2016 at 12:41:50PM +0800, Zorro Lang wrote:
> xfs/106 try to do some basic xfs_quota functionality test. I think
> basic function test is important, especially there're only few
> cases about xfs_quota now. But due to it's too old, there're 3
> problems cause no one run it again:
>    1. Some quota commands can't be used, but this case try to use it.
>       e.g. "warn" command.
>    2. Some quota commands can be used now, but this case doesn't test
>       them, because they can't work previously. e.g. "disable, enable,
>       off and remove" comands
>    3. Some expected output in 106.out file become incorrect now.
> 
> I rewrite this case for above 3 reasons. This case nearly test all
> xfs_quota commands and options now, except:
>    1. some "-v" options
>    2. all "-a" options. I can't control the golden file if print all
>       filesystem's quota info in it.
>    3. default quota. I think it can be tested in another case.
>    4. project command options. I will write another case to test it.
>    5. report command -l option. It's a new option, will cause failure
>       if someone test on a release with xfsprogs-3.1.
>    6. quot command -c option. It maybe output different histogram in
>       different system or machine.
>    7. warn command. This feature is not currently implemented.
>    8. print, df, free, help, quit and path commands.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---

I'm not so familiar with xfs quota, so I just ran the test and review it
from a more general perspective.

The test works well on v5 xfs, but it fails when test on v4 xfs, e.g.

[root@dhcp-66-86-11 xfstests]# diff -u tests/xfs/106.out /root/workspace/xfstests/results//xfs_512/xfs/106.out.bad
--- tests/xfs/106.out   2016-05-23 15:07:41.439000000 +0800
+++ /root/workspace/xfstests/results//xfs_512/xfs/106.out.bad   2016-05-23 15:15:16.558000000 +0800
@@ -349,10 +349,12 @@
 Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
 ---------- -------------------------------------------------- --------------------------------------------------
 fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
...

Maybe the test needs more filters?

Also, it fails fsck on v4 xfs, but this is not xfs/106 specific, I saw
many other quota related tests failed the same way with v4 xfs. (I
reported this issue to xfs list along other issues back in Mar., see
http://oss.sgi.com/archives/xfs/2016-03/msg00063.html).

*** xfs_repair -n output ***
Phase 1 - find and verify superblock...
Phase 2 - using internal log
        - zero log...
        - scan filesystem freespace and inode maps...
        - found root inode chunk
Phase 3 - for each AG...
        - scan (but don't clear) agi unlinked lists...
        - process known inodes and perform inode discovery...
        - agno = 0
        - agno = 1
        - agno = 2
        - agno = 3
        - process newly discovered inodes...
Phase 4 - check for duplicate blocks...
        - setting up duplicate extent list...
        - check for inodes claiming duplicate blocks...
        - agno = 0
        - agno = 2
        - agno = 1
        - agno = 3
No modify flag set, skipping phase 5
Phase 6 - check inode connectivity...
        - traversing filesystem ...
        - traversal finished ...
        - moving disconnected inodes to lost+found ...
disconnected inode 36, would move to lost+found
Phase 7 - verify link counts...
No modify flag set, skipping filesystem flush and exiting.
*** end xfs_repair output


And some minor (coding style) comments inline.

> 
> Hi,
> 
> V2 changed below:
[snip]
> diff --git a/tests/xfs/106 b/tests/xfs/106
> index 74658a6..f8593d0 100755
> --- a/tests/xfs/106
> +++ b/tests/xfs/106
> @@ -31,208 +31,289 @@ echo "QA output created by $seq"
>  here=`pwd`
>  tmp=/tmp/$$
>  status=1	# failure is the default!
> -trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +    cd /
> +    rm -f $tmp.*

Seems you use 4 spaces for indention, please use tab instead (8 spaces
width). Some old tests are using 4 spaces for indention, but we're in
the progress to convert all these tests to use tab (very slowly), mainly
by the chance of updating old tests like this :)

> +}
>  
>  # get standard environment, filters and checks
>  . ./common/rc
>  . ./common/filter
>  . ./common/quota
>  
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
>  _supported_fs xfs
> -_supported_os Linux #IRIX
> +_supported_os Linux
>  _require_scratch
>  _require_xfs_quota
> +_require_user
> +_require_group
>  
> -# real QA test starts here
> -_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
> -cat $tmp.mkfs >$seqres.full
> -. $tmp.mkfs
> +_scratch_mkfs_xfs >$seqres.full 2>&1
>  
> -# setup a default run
> -if [ -z "$MOUNT_OPTIONS" ]; then
> -	export MOUNT_OPTIONS="-o pquota,sync"
> -else
> -	export MOUNT_OPTIONS="$MOUNT_OPTIONS -o sync"
> -fi
> +uqid=`id -u fsgqa`
> +gqid=`id -g fsgqa`
> +pqid=10
> +cat >$tmp.projects <<EOF
> +$pqid:$SCRATCH_MNT
> +EOF
>  
> -_qmount
> -_require_prjquota $SCRATCH_DEV
> +cat >$tmp.projid <<EOF
> +root:0
> +fsgqa:$pqid
> +EOF
>  
> -# initial populate
> -target=$SCRATCH_MNT/target
> -$FSSTRESS_PROG -z -s 57069 -m 8 -n 1000 -p 4 \
> --f allocsp=1 \
> --f chown=3 \
> --f creat=4 \
> --f dwrite=4 \
> --f fallocate=1 \
> --f fdatasync=1 \
> --f fiemap=1 \
> --f freesp=1 \
> --f fsync=1 \
> --f link=1 \
> --f mkdir=2 \
> --f mknod=2 \
> --f punch=1 \
> --f rename=2 \
> --f resvsp=1 \
> --f rmdir=1 \
> --f setxattr=1 \
> --f symlink=2 \
> --f sync=1 \
> --f truncate=2 \
> --f unlink=1 \
> --f unresvsp=1 \
> --f write=4 \
> --d $target
> -
> -$FSSTRESS_PROG -z -s 57069 -m 8 -n 1000 -p 4 \
> --f chown=500 \
> --f setxattr=500 \
> --d $target
> -
> -# also use space, to be able to go over/under limits easily
> -uid=255
> -gid=254
> -prid=253
> -rm -f $SCRATCH_MNT/resv
> -$XFS_IO_PROG -fc "resvsp 0 200m" -c "chproj $prid" $SCRATCH_MNT/resv
> -chown $uid $SCRATCH_MNT/resv
> -chgrp $gid $SCRATCH_MNT/resv
> +create_files()
> +{
> +    local bs=$1
> +    local inum=$2
>  
> -_qmount
> +    echo "Using type=$type id=$id" >> $seqres.full
> +
> +    for ((i=0; i<$((inum-1)); i++))
> +    do
> +	_file_as_id $SCRATCH_MNT/inode$i $id $type 1024 0
> +    done

Please use this for format

	for ...; do
		...
	done

Thanks,
Eryu
