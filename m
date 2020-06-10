Return-Path: <SRS0=2A/Q=7X=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22C8C433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Jun 2020 02:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952B0207ED
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Jun 2020 02:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgFJCCu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:02:50 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60760 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725798AbgFJCCt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 9 Jun 2020 22:02:49 -0400
X-IronPort-AV: E=Sophos;i="5.73,494,1583164800"; 
   d="scan'208";a="94211337"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Jun 2020 10:02:02 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 217A44CE26C8;
        Wed, 10 Jun 2020 10:02:01 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 10 Jun 2020 10:01:59 +0800
Message-ID: <5EE03F16.3030402@cn.fujitsu.com>
Date:   Wed, 10 Jun 2020 10:01:58 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <fstests@vger.kernel.org>, <ira.weiny@intel.com>
Subject: Re: [PATCH 1/4] common/rc: Introduce new helpers for DAX mount options
 and FS_XFLAG_DAX
References: <20200603140115.30392-1-yangx.jy@cn.fujitsu.com> <20200609163908.GA11255@magnolia>
In-Reply-To: <20200609163908.GA11255@magnolia>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 217A44CE26C8.A88FC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Darrick,

Thanks a lot for your comments.

On 2020/6/10 0:39, Darrick J. Wong wrote:
> Oh, this wasn't the cover letter. ;)

I will add the cover letter.

>
> On Wed, Jun 03, 2020 at 10:01:12PM +0800, Xiao Yang wrote:
>> 1) _require_scratch_dax_mountopt() checks both old and new DAX mount option
>> 2) _require_scratch_daX_iflag() checks FS_XFLAG_DAX
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   common/rc | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index a6967831..ec7c19e4 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3188,6 +3188,41 @@ _require_scratch_dax()
>>   	_scratch_unmount
>>   }
>>
>> +_require_scratch_dax_mountopt()
>> +{
>> +	local mountopt=$1
>> +	local output
>> +
>> +	_require_scratch
>> +	_scratch_mkfs>  /dev/null 2>&1
>> +	_try_scratch_mount -o "$mountopt" || \
>> +		_notrun "mount $SCRATCH_DEV with $mountopt failed"
>
> What happens if MOUNT_OPTS already contains a dax option?  Should we
> clear it out ala _qmount_option, on the assumption that a test that
> cares about specific options probably wants to override whatever the
> test runner passed in?

Good point, but it seems that the last dax option is actually used if we 
mount with multiple dax options, as below:
----------------------------------------------
ext4:
# blkid /dev/pmem1
/dev/pmem1: UUID="cd2eb9f0-af2a-4c89-a381-4d2d9d2e8054" TYPE="ext4"
# mount -o dax -odax=inode /dev/pmem1 /mnt/xfstests/scratch/
# mount | grep pmem1
/dev/pmem1 on /mnt/xfstests/scratch type ext4 
(rw,relatime,seclabel,dax=inode)

# mount -o dax=never -odax=inode -odax=always /dev/pmem1 
/mnt/xfstests/scratch/
# mount | grep pmem1
/dev/pmem1 on /mnt/xfstests/scratch type ext4 
(rw,relatime,seclabel,dax=always)

# mount -o dax=never -odax /dev/pmem1 /mnt/xfstests/scratch/
# mount | grep pmem1
/dev/pmem1 on /mnt/xfstests/scratch type ext4 
(rw,relatime,seclabel,dax=always)


xfs:
# blkid /dev/pmem0
/dev/pmem0: UUID="bc830790-1ea8-48fb-9cda-7d5bb96b8961" TYPE="xfs"
# mount -o dax=never -o dax=always /dev/pmem0 /mnt/xfstests/test/
# mount | grep pmem0
/dev/pmem0 on /mnt/xfstests/test type xfs 
(rw,relatime,seclabel,attr2,dax=always,inode64,logbufs=8,logbsize=32k,noquota)

# mount -o dax=never -o dax=inode /dev/pmem0 /mnt/xfstests/test/
# mount | grep pmem0
/dev/pmem0 on /mnt/xfstests/test type xfs 
(rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)

# mount -o dax=always -o dax=inode -o dax=never /dev/pmem0 
/mnt/xfstests/test/
# mount | grep pmem0
/dev/pmem0 on /mnt/xfstests/test type xfs 
(rw,relatime,seclabel,attr2,dax=never,inode64,logbufs=8,logbsize=32k,noquota)
----------------------------------------------
all dax options are exclusive, so do you think is it necessary to 
implement a function as _qmount_option?

Best Regards,
Xiao Yang
>
> --D
>
>> +
>> +	output=$(_fs_options $SCRATCH_DEV)
>> +
>> +	# For new dax mount option, /proc/mounts shows different outputs if we
>> +	# mount with -o dax=inode on ext4 and xfs so skip checking it.
>> +	# /proc/mounts shows 'dax=inode' on ext4 but shows nothing on xfs.
>> +	if [ "$mountopt" != "dax=inode" ]; then
>> +		echo $output | grep -qw "$mountopt" || \
>> +			_notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
>> +	fi
>> +
>> +	# For new dax mount option, /proc/mounts shows "dax=never" if we
>> +	# mount with -o dax on xfs and underlying device doesn't support dax.
>> +	if [ "$mountopt" = "dax" ]; then
>> +		echo $output | grep -qw "dax=never"&&  \
>> +			_notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
>> +	fi
>> +
>> +	_scratch_unmount
>> +}
>> +
>> +_require_scratch_dax_iflag()
>> +{
>> +	_require_xfs_io_command "chattr" "x"
>> +}
>> +
>>   # Does norecovery support by this fs?
>>   _require_norecovery()
>>   {
>> --
>> 2.21.0
>>
>>
>>
>
>
> .
>



