Return-Path: <SRS0=wEx+=77=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67013C433DF
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Jun 2020 15:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4620C206FA
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Jun 2020 15:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ImFPGxfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgFRPgi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:36:38 -0400
Received: from m12-17.163.com ([220.181.12.17]:56039 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbgFRPgh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Jun 2020 11:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=mLbzK
        Y4gJXg+pFMOdLaRcEQcCfqRp+ngzMMBBoHisMo=; b=ImFPGxfYbj/1XHWE7YUdB
        FB58eLTmytJJWpDU5XqhtchcI/hR4oWC8AYORH7eMzXsytQNfypjsJ+kMlt4ty81
        +MZiqGnMSIv1fuImhVbHV+E7nTez7rpIyW/CgTDBmDuShkiodmPSfjASdhK/WJwm
        dRFFZhUatydNCfP4QrqO5I=
Received: from [192.168.0.10] (unknown [183.210.49.20])
        by smtp13 (Coremail) with SMTP id EcCowAAX2ivcieteURG0IA--.62731S2;
        Thu, 18 Jun 2020 23:35:57 +0800 (CST)
Subject: Re: [PATCH v2 6/6] xfs/260: Move xfs/260 to generic
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com,
        ross.zwisler@linux.intel.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
 <20200617093204.20838-7-ice_yangxiao@163.com>
 <20200617214857.GN4160762@iweiny-DESK2.sc.intel.com>
From:   Xiao Yang <ice_yangxiao@163.com>
Message-ID: <a2b565a7-7ff8-7201-1921-4724d8117cbb@163.com>
Date:   Thu, 18 Jun 2020 23:35:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200617214857.GN4160762@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: EcCowAAX2ivcieteURG0IA--.62731S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr4xAr1fCrWDtFW8CFyfWFg_yoW7Zry3pF
        y8A3y5CFWrJ340kw18t3Z8ZFy8ZryFqa1j9r1xX34kZFy5WasrG3yxWF4IgFZ5W3s3AF4a
        9ws5JryrGwn0yFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j973kUUUUU=
X-Originating-IP: [183.210.49.20]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiMx1HXlXl4fIiogAAsU
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 6/18/20 5:48 AM, Ira Weiny wrote:
> On Wed, Jun 17, 2020 at 05:32:04PM +0800, Xiao Yang wrote:
>> From: Xiao Yang <yangx.jy@cn.fujitsu.com>
>>
>> Both ext4 and xfs support per-inode DAX flag now so move it to generic.
>>
>> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> Unfortunately this test needs to be modified to work with the final agreed upon
> method for switching DAX, patch below.  Feel free to squash it into this patch
> for v3.
>
> There are more checks I had queued up but I'm happy to wait for this series to
> be applied.
>
> Again, thanks for moving this along!
> Ira
>
>  From 97b67a2773627cfe91b5f33a418ab646bb5fd0a8 Mon Sep 17 00:00:00 2001
> From: Ira Weiny <ira.weiny@intel.com>
> Date: Wed, 17 Jun 2020 14:34:45 -0700
> Subject: [PATCH] generic/602: Modify to work with agreed inheritance of DAX flag
>
> Modifying the DAX flag on flies does not take effect immediately.  The
> easiest way to ensure the file state for this test is to use inheritance
> of the parent directory DAX state.

Hi Ira,

Modifying the DAX flag on directories can take effect immediately, right?

>
> Modify the test to use 2 directories which we can switch the DAX state on
> and create the test files in those directories after setting the desired
> state.

Good addition, and I will squash it into this v3 patch. :-)

BTW:

I wait someone(Darrick, Eryu or others) to review the code about PMD 
fault testing in this patch set.

Best Regards,

Xiao Yang

>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>   tests/generic/602 | 81 +++++++++++++++++++++++++++++------------------
>   1 file changed, 51 insertions(+), 30 deletions(-)
>
> diff --git a/tests/generic/602 b/tests/generic/602
> index 9137c5b9385f..20bf2c6bd246 100755
> --- a/tests/generic/602
> +++ b/tests/generic/602
> @@ -36,68 +36,95 @@ _require_test_program "t_mmap_dio"
>   _require_scratch_dax_iflag
>   _require_xfs_io_command "falloc"
>   
> -prep_files()
> +SRC_DIR=$SCRATCH_MNT/src
> +SRC_FILE=$SRC_DIR/tf_s
> +
> +DST_DIR=$SCRATCH_MNT/dst
> +DST_FILE=$DST_DIR/tf_d
> +
> +clean_files()
>   {
> -	rm -f $SCRATCH_MNT/tf_{s,d}
> +	rm -f $SRC_FILE
> +	rm -f $DST_FILE
>   
> +	mkdir -p $SRC_DIR
> +	mkdir -p $DST_DIR
> +}
> +
> +prep_files()
> +{
> +	$XFS_IO_PROG -f -c "falloc 0 $tsize" \
> +		$SRC_FILE >> $seqres.full 2>&1
>   	$XFS_IO_PROG -f -c "falloc 0 $tsize" \
> -		$SCRATCH_MNT/tf_{s,d} >> $seqres.full 2>&1
> +		$DST_FILE >> $seqres.full 2>&1
>   }
>   
>   t_both_dax()
>   {
> +	clean_files
> +	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
> +	$XFS_IO_PROG -c "chattr +x" $DST_DIR
>   	prep_files
> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
>   	# with O_DIRECT first
> -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} $1 "dio both dax"
> +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE $1 "dio both dax"
>   
> +	clean_files
> +	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
> +	$XFS_IO_PROG -c "chattr +x" $DST_DIR
>   	prep_files
> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
>   	# again with buffered IO
> -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
> +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
>   		$1 "buffered both dax"
>   }
>   
>   t_nondax_to_dax()
>   {
> +	clean_files
> +	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
> +	$XFS_IO_PROG -c "chattr +x" $DST_DIR
>   	prep_files
> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
> -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
> +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
>   		$1 "dio nondax to dax"
>   
> +	clean_files
> +	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
> +	$XFS_IO_PROG -c "chattr +x" $DST_DIR
>   	prep_files
> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
> -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
> +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
>   		$1 "buffered nondax to dax"
>   }
>   
>   t_dax_to_nondax()
>   {
> +	clean_files
> +	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
> +	$XFS_IO_PROG -c "chattr -x" $DST_DIR
>   	prep_files
> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
> -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
> +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
>   		$1 "dio dax to nondax"
>   
> +	clean_files
> +	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
> +	$XFS_IO_PROG -c "chattr -x" $DST_DIR
>   	prep_files
> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
> -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
> +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
>   		$1 "buffered dax to nondax"
>   }
>   
>   t_both_nondax()
>   {
> +	clean_files
> +	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
> +	$XFS_IO_PROG -c "chattr -x" $DST_DIR
>   	prep_files
> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
> -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
> +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
>   		$1 "dio both nondax"
>   
> +	clean_files
> +	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
> +	$XFS_IO_PROG -c "chattr -x" $DST_DIR
>   	prep_files
> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
> -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
> +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
>   		$1 "buffered both nondax"
>   }
>   
> @@ -124,17 +151,11 @@ do_tests()
>   # make xfs aligned for PMD fault testing
>   _scratch_mkfs_geom $(_get_hugepagesize) 1 >> $seqres.full 2>&1
>   
> -# mount with dax option
> -_scratch_mount "-o dax"
> -
>   tsize=$((128 * 1024 * 1024))
>   
> -do_tests
> -_scratch_unmount
> -
>   # mount again without dax option
>   export MOUNT_OPTIONS=""
> -_scratch_mount
> +_scratch_mount "-o dax=inode"
>   do_tests
>   
>   # success, all done

