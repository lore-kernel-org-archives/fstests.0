Received: from mx2.suse.de ([195.135.220.15]:45968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751672AbdCNOHJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Mar 2017 10:07:09 -0400
Subject: Re: [PATCH] common/rc: Use -v option with findmnt
References: <20170313180726.1967-1-rgoldwyn@suse.de>
 <20170314050739.GY14226@eguan.usersys.redhat.com>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <34649364-41c7-7d05-45a3-616c45cc59cf@suse.de>
Date: Tue, 14 Mar 2017 09:07:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170314050739.GY14226@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>



On 03/14/2017 12:07 AM, Eryu Guan wrote:
> On Mon, Mar 13, 2017 at 01:07:26PM -0500, Goldwyn Rodrigues wrote:
>> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>>
>> Since btrfs puts in the subvol name in the device, we should
>> use -v option to not print the bind mounts or btrfs volumes.
>>
>> Fixes: 5e6892d ("common/rc: use findmnt to check mounted device")
>> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Hmm, I mounted a btrfs snapshot of TEST_DEV to another dir and ran
> check, check reported:
> 
> TEST_DEV=/dev/sdc1 is mounted but not on TEST_DIR=/mnt - aborting
> Already mounted result:
> /dev/sdc1[/snap] /mnt/scratch
> 
> which seems fine and clear to me. Did you hit any particular failures
> without this fix?


The problem is you hit this error even if /dev/sdc1 is mounted on
TEST_DIR=/mnt because of the subvolume name appended to the device name.

IOW, the test fails when it should not have. Here is an output of
executing btrfs/021:

    --- tests/btrfs/021.out	2017-01-26 02:23:04.444778259 -0600
    +++ /fiona/xfstests/results//btrfs/021.out.bad	2017-03-14
04:25:38.807212599 -0500
    @@ -1,2 +1,4 @@
     QA output created by 021
    -Silence is golden
    +SCRATCH_DEV=/dev/vdc is mounted but not on SCRATCH_MNT=/scratch -
aborting
    +Already mounted result:
    +/dev/vdc[/newvol] /scratch

However, this fix is incorrect.

I found that this was because of reminiscences of btrfs/009
Adding _scratch_umount to the end of btrfs/009 solves the issue, since
the filesystem is created fresh in the next test.

The filesystem was not created fresh in the next test because findmnt
would fail in _require_scratch.

I will shortly post a new patch which would fix this.



-- 
Goldwyn
