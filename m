Return-Path: <SRS0=gdhN=AE=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D74C433E0
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Jun 2020 08:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3779320723
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Jun 2020 08:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbgFWIwO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:52:14 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41560 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731691AbgFWIwO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Jun 2020 04:52:14 -0400
X-IronPort-AV: E=Sophos;i="5.75,270,1589212800"; 
   d="scan'208";a="95142308"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jun 2020 16:51:38 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 016A94CE3F0C;
        Tue, 23 Jun 2020 16:41:11 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 23 Jun 2020 16:51:32 +0800
Message-ID: <5EF1C293.4010104@cn.fujitsu.com>
Date:   Tue, 23 Jun 2020 16:51:31 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Xiao Yang <ice_yangxiao@163.com>, <fstests@vger.kernel.org>,
        <darrick.wong@oracle.com>, <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v2 6/6] xfs/260: Move xfs/260 to generic
References: <20200617093204.20838-1-ice_yangxiao@163.com> <20200617093204.20838-7-ice_yangxiao@163.com> <20200617214857.GN4160762@iweiny-DESK2.sc.intel.com> <a2b565a7-7ff8-7201-1921-4724d8117cbb@163.com> <20200619151511.GR4160762@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200619151511.GR4160762@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 016A94CE3F0C.AFB13
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/6/19 23:15, Ira Weiny wrote:
> On Thu, Jun 18, 2020 at 11:35:56PM +0800, Xiao Yang wrote:
>> On 6/18/20 5:48 AM, Ira Weiny wrote:
>>> On Wed, Jun 17, 2020 at 05:32:04PM +0800, Xiao Yang wrote:
>>>> From: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>>>
>>>> Both ext4 and xfs support per-inode DAX flag now so move it to generic.
>>>>
>>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>> Unfortunately this test needs to be modified to work with the final agreed upon
>>> method for switching DAX, patch below.  Feel free to squash it into this patch
>>> for v3.
>>>
>>> There are more checks I had queued up but I'm happy to wait for this series to
>>> be applied.
>>>
>>> Again, thanks for moving this along!
>>> Ira
>>>
>>>   From 97b67a2773627cfe91b5f33a418ab646bb5fd0a8 Mon Sep 17 00:00:00 2001
>>> From: Ira Weiny<ira.weiny@intel.com>
>>> Date: Wed, 17 Jun 2020 14:34:45 -0700
>>> Subject: [PATCH] generic/602: Modify to work with agreed inheritance of DAX flag
>>>
>>> Modifying the DAX flag on flies does not take effect immediately.  The
>>> easiest way to ensure the file state for this test is to use inheritance
>>> of the parent directory DAX state.
>> Hi Ira,
>>
>> Modifying the DAX flag on directories can take effect immediately, right?
> Yes and any file created under that directory will inherit the DAX flag
> immediately.
>
>>> Modify the test to use 2 directories which we can switch the DAX state on
>>> and create the test files in those directories after setting the desired
>>> state.
>> Good addition, and I will squash it into this v3 patch. :-)
>>
>> BTW:
>>
>> I wait someone(Darrick, Eryu or others) to review the code about PMD fault
>> testing in this patch set.
> Yes, thanks.  I don't feel familiar enough with that code to review it.
>
> Ira
>
>> Best Regards,
>>
>> Xiao Yang
>>
>>> Signed-off-by: Ira Weiny<ira.weiny@intel.com>
>>> ---
>>>    tests/generic/602 | 81 +++++++++++++++++++++++++++++------------------
>>>    1 file changed, 51 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/tests/generic/602 b/tests/generic/602
>>> index 9137c5b9385f..20bf2c6bd246 100755
>>> --- a/tests/generic/602
>>> +++ b/tests/generic/602
>>> @@ -36,68 +36,95 @@ _require_test_program "t_mmap_dio"
>>>    _require_scratch_dax_iflag
>>>    _require_xfs_io_command "falloc"
>>> -prep_files()
>>> +SRC_DIR=$SCRATCH_MNT/src
>>> +SRC_FILE=$SRC_DIR/tf_s
>>> +
>>> +DST_DIR=$SCRATCH_MNT/dst
>>> +DST_FILE=$DST_DIR/tf_d
>>> +
>>> +clean_files()
>>>    {
>>> -	rm -f $SCRATCH_MNT/tf_{s,d}
>>> +	rm -f $SRC_FILE
>>> +	rm -f $DST_FILE
>>> +	mkdir -p $SRC_DIR
>>> +	mkdir -p $DST_DIR
>>> +}
>>> +
>>> +prep_files()
>>> +{
>>> +	$XFS_IO_PROG -f -c "falloc 0 $tsize" \
>>> +		$SRC_FILE>>  $seqres.full 2>&1
>>>    	$XFS_IO_PROG -f -c "falloc 0 $tsize" \
>>> -		$SCRATCH_MNT/tf_{s,d}>>  $seqres.full 2>&1
>>> +		$DST_FILE>>  $seqres.full 2>&1
>>>    }
>>>    t_both_dax()
>>>    {
>>> +	clean_files
>>> +	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
>>> +	$XFS_IO_PROG -c "chattr +x" $DST_DIR
>>>    	prep_files
>>> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
>>>    	# with O_DIRECT first
>>> -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} $1 "dio both dax"
>>> +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE $1 "dio both dax"
>>> +	clean_files
>>> +	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
>>> +	$XFS_IO_PROG -c "chattr +x" $DST_DIR
>>>    	prep_files
>>> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
>>>    	# again with buffered IO
>>> -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
>>> +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
>>>    		$1 "buffered both dax"
>>>    }
>>>    t_nondax_to_dax()
>>>    {
>>> +	clean_files
>>> +	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
>>> +	$XFS_IO_PROG -c "chattr +x" $DST_DIR
>>>    	prep_files
>>> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
>>> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
>>> -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
>>> +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
>>>    		$1 "dio nondax to dax"
>>> +	clean_files
>>> +	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
>>> +	$XFS_IO_PROG -c "chattr +x" $DST_DIR
>>>    	prep_files
>>> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
>>> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
>>> -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
>>> +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
>>>    		$1 "buffered nondax to dax"
>>>    }
>>>    t_dax_to_nondax()
>>>    {
>>> +	clean_files
>>> +	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
>>> +	$XFS_IO_PROG -c "chattr -x" $DST_DIR
>>>    	prep_files
>>> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
>>> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
>>> -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
>>> +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
>>>    		$1 "dio dax to nondax"
>>> +	clean_files
>>> +	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
>>> +	$XFS_IO_PROG -c "chattr -x" $DST_DIR
>>>    	prep_files
>>> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
>>> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
>>> -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
>>> +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
>>>    		$1 "buffered dax to nondax"
>>>    }
>>>    t_both_nondax()
>>>    {
>>> +	clean_files
>>> +	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
>>> +	$XFS_IO_PROG -c "chattr -x" $DST_DIR
>>>    	prep_files
>>> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
>>> -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
>>> +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
>>>    		$1 "dio both nondax"
>>> +	clean_files
>>> +	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
>>> +	$XFS_IO_PROG -c "chattr -x" $DST_DIR
>>>    	prep_files
>>> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
>>> -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
>>> +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
>>>    		$1 "buffered both nondax"
>>>    }
>>> @@ -124,17 +151,11 @@ do_tests()
>>>    # make xfs aligned for PMD fault testing
>>>    _scratch_mkfs_geom $(_get_hugepagesize) 1>>  $seqres.full 2>&1
>>> -# mount with dax option
>>> -_scratch_mount "-o dax"
>>> -
Hi Ira,

Why do you want to remove this combination(i.e. test per-inode DAX flag 
under mounting with dax option) ?
Is it because mounting with dax option ignore FS_XFLAG_DAX flag?
I think it is a reasonable combination. :-)

>>>    tsize=$((128 * 1024 * 1024))
>>> -do_tests
>>> -_scratch_unmount
>>> -
>>>    # mount again without dax option
>>>    export MOUNT_OPTIONS=""
>>> -_scratch_mount
>>> +_scratch_mount "-o dax=inode"
>>>    do_tests
>>>    # success, all done

Could we keep _scratch_mount without dax so that this test can run on 
both old and new kernel?
See the following reasons:
1) FS_XFLAG_DAX was introduced by commit 58f88ca("xfs: introduce 
per-inode DAX enablement") since 2017.
2) _scratch_mount with dax=inode is equal to _scratch_mount without dax.

Best Regards,
Xiao Yang
>
> .
>



