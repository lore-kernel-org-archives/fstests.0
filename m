Return-Path: <SRS0=QBZa=C7=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B33C2D0E2
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Sep 2020 08:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB2F2085B
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Sep 2020 08:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgIVItn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Sep 2020 04:49:43 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:62476 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726098AbgIVItm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Sep 2020 04:49:42 -0400
X-IronPort-AV: E=Sophos;i="5.77,290,1596470400"; 
   d="scan'208";a="99498741"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Sep 2020 16:49:40 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id EDC6148990EF;
        Tue, 22 Sep 2020 16:49:36 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 22 Sep 2020 16:49:34 +0800
Message-ID: <5F69BA9E.7040201@cn.fujitsu.com>
Date:   Tue, 22 Sep 2020 16:49:34 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Zorro Lang <zlang@redhat.com>
CC:     <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/611: remove _supported_os line
References: <20200921043144.8057-1-zlang@redhat.com>
In-Reply-To: <20200921043144.8057-1-zlang@redhat.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: EDC6148990EF.AA3BF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/9/21 12:31, Zorro Lang wrote:
> The current xfstests doesn't support _supported_os() function, the
> generic/611 always hit an error:
>
>   xfstests-dev/tests/generic/611: line 39: _supported_os: command not found
>
> So remove the "_supported_os Linux" line directly.
Hi Zorro,

It seems better to add a fix tag:
Fixes: a860a167d87a ("common: kill _supported_os")

Other than that it is fine for me. :-)
Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Best Regards,
Xiao Yang
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/generic/611 | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tests/generic/611 b/tests/generic/611
> index 069db6f9..f4158bb3 100755
> --- a/tests/generic/611
> +++ b/tests/generic/611
> @@ -36,7 +36,6 @@ rm -f $seqres.full
>  # real QA test starts here
>  
>  _supported_fs generic
> -_supported_os Linux
>  _require_scratch
>  _require_attrs
>  



