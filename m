Return-Path: <SRS0=A77W=2N=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72240C2D0C8
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Dec 2019 01:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7D2206B7
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Dec 2019 01:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfLWBZE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 Dec 2019 20:25:04 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20471 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726190AbfLWBZD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Dec 2019 20:25:03 -0500
X-IronPort-AV: E=Sophos;i="5.69,345,1571673600"; 
   d="scan'208";a="80608232"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Dec 2019 09:25:02 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 0C76B4CE1C93;
        Mon, 23 Dec 2019 09:16:14 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 23 Dec 2019 09:25:01 +0800
Subject: Re: [PATCH] generic/386: check the correct field from df output
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <fstests@vger.kernel.org>, <sandeen@sandeen.net>
References: <20191222212730.378358-1-tytso@mit.edu>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <ae961477-f14a-60b3-9784-909470bc2bc8@cn.fujitsu.com>
Date:   Mon, 23 Dec 2019 09:24:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20191222212730.378358-1-tytso@mit.edu>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 0C76B4CE1C93.A18A8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



on 2019/12/23 5:27, Theodore Ts'o wrote:
> The generic/386 test was checking the "Available" field when it should
> have been checking the "1k-blocks" field, which represents the project
> quota's hard limit.  On xfs, an empty directory takes no space, so it
> doesn't matter.  But for ext4, an empty directory still takes 4k (or
> whatever the file system's block size happens to be):
> 
> Filesystem           1K-blocks       Used  Available  Use% Pathname
> /dev/vdc                512000          4     511996    0% /vdc/test
> 
> This causes generic/386 to falsely fail.  There was a confusing
> comment claiming that for a very long device name, the df output would
> have a line break, and for that reason, the test would extract the
> field using $(NF-2).  However, looking at xfsprogs's quota command, I
> see no evidence that there is any line breaking logic.  Since we now
> want to use the second field, even if there was some line breaking
> going on, using $2 should be a better choice.
> 
> This fix is needed to fix generic/386 from failing on ext4:
Hi Theodore

I have a same fix but I use $(NF-4) field of df command. Also I wrongly 
think project quota uses a block size.
url:
https://patchwork.kernel.org/patch/11296657/

Best Regards
Yang Xu
> 
>      hard limit 524283904 bytes, expected 524288000
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>   tests/generic/386 | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tests/generic/386 b/tests/generic/386
> index 0c44c80e..37e9b943 100755
> --- a/tests/generic/386
> +++ b/tests/generic/386
> @@ -62,8 +62,6 @@ _require_scratch
>   # both the "df" and the "report" output.  For "report", the line we're
>   # interested in contains our project name in the first field.  For "df"
>   # it contains our project directory in the last field.
> -# But if the device name is too long, the "df" output is broke into two
> -# lines, the fourth field is not correct, so take $(NF-2) of "df"
>   _filter_quota_rpt() {
>   	awk '
>   	BEGIN {
> @@ -89,7 +87,7 @@ _filter_quota_rpt() {
>   			bsize = byte_size($4);
>   		} else if ($NF ~ proj_dir) {
>   			# this is the "df" output
> -			bsize = byte_size($(NF-2));
> +			bsize = byte_size($2));
>   		} else {
>   			next;
>   		}
> 


