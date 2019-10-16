Return-Path: <SRS0=dVie=YJ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4E6ECE59D
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Oct 2019 04:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7691820872
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Oct 2019 04:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfJPEFt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Oct 2019 00:05:49 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46987 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbfJPEFs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Oct 2019 00:05:48 -0400
X-Greylist: delayed 1340 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Oct 2019 00:05:47 EDT
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9176B43EEBA;
        Wed, 16 Oct 2019 14:43:26 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iKaDd-000342-DF; Wed, 16 Oct 2019 14:43:25 +1100
Date:   Wed, 16 Oct 2019 14:43:25 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     guaneryu@gmail.com, darrick.wong@oracle.com,
        fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] common/rc: generalize _get_filesize()
Message-ID: <20191016034325.GI15134@dread.disaster.area>
References: <20191016024803.12028-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016024803.12028-1-yuchao0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=i0EeH86SAAAA:8 a=7-415B0cAAAA:8 a=TByWkiWk5-4v4GWVltUA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 16, 2019 at 10:48:03AM +0800, Chao Yu wrote:
> There are some testcases use below command to get file size, generalize
> it as global function _get_filesize()
> 
> ls -l $1 | $AWK_PROG '{print $5}'
> 
> And in addition, using more simple command "stat -c %s" instead.
> 
> - adjust common/defrag, generic/275 and generic/315 to use it
> - remove unused _filesize in generic/013
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v3:
> - avoid unneeded echo command in _get_filesize() pointed out by Darrick.
>  common/defrag     | 2 +-
>  common/rc         | 5 +++++
>  tests/generic/013 | 5 -----
>  tests/generic/275 | 2 +-
>  tests/generic/315 | 2 +-
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/common/defrag b/common/defrag
> index 1381a4dd..1769013b 100644
> --- a/common/defrag
> +++ b/common/defrag
> @@ -145,7 +145,7 @@ _defrag()
>  	STAT_BEFORE=`stat -c "a: %x m: %y c: %z" $1`
>  
>  	if [ $FSTYP == "f2fs" ]; then
> -		local filesize=`ls -l $1 | $AWK_PROG '{print $5}'`
> +		local filesize=`_get_filesize $1`
>  		$DEFRAG_PROG 0 $filesize $1 >> $seqres.full 2>&1
>  	else
>  		$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
> diff --git a/common/rc b/common/rc
> index cfaabf10..8cdb7a9b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -165,6 +165,11 @@ if [ ! -z "$REPORT_LIST" ]; then
>  	_assert_report_list
>  fi
>  
> +_get_filesize()
> +{
> +    stat -c %s "$1"
> +}

Also, all these should use _get_filesize():

$ git grep 'stat -c %s'
tests/btrfs/086:echo "bar file size after clone operation: $(stat -c %s $SCRATCH_MNT/bar)"
tests/generic/399:                      total_file_size=$((total_file_size + $(stat -c %s $file)))
tests/generic/399:      total_file_size=$((total_file_size + $(stat -c %s $file)))
tests/xfs/306:size=`stat -c %s $SCRATCH_MNT/file`
$ git grep 'stat -c "%s"'
tests/generic/286:      test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
tests/generic/286:      test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
tests/generic/286:      test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
tests/generic/286:      test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
tests/overlay/060:      actual_size=$(stat -c "%s" $target)
tests/xfs/014:  size=`stat -c "%s" $file`
tests/xfs/076:offset=`stat -c "%s" $SCRATCH_MNT/spc`


Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
