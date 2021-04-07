Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9BAC433B4
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Apr 2021 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3CA610FB
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Apr 2021 17:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhDGRDW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Apr 2021 13:03:22 -0400
Received: from sandeen.net ([63.231.237.45]:48568 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343936AbhDGRDT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 7 Apr 2021 13:03:19 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 142FA5EDA8;
        Wed,  7 Apr 2021 12:02:09 -0500 (CDT)
To:     Pavel Reichl <preichl@redhat.com>, fstests@vger.kernel.org
Cc:     zlang@redhat.com, guan@eryu.me
References: <20210330220005.56019-1-preichl@redhat.com>
 <20210330220005.56019-3-preichl@redhat.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH v2 2/4] common: hide permision warning from mkswap for
 exfat
Message-ID: <54667422-1a39-7a78-5dda-e417d0323f52@sandeen.net>
Date:   Wed, 7 Apr 2021 12:03:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210330220005.56019-3-preichl@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/30/21 5:00 PM, Pavel Reichl wrote:
> exfat does not support posix file permisions, so warning from mkswap is
> inavitable. This patch hides the warning message so the test won't fail.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>

hah, I never even thought about swap on exfat ;)

Assuming it actually works other than this warning, maybe you don't need to
special case it for exfat? If so just filter that warning for everyone (in the
same way that the CHATTR isn't special cased for btrfs; we just ignore
failures there, because they don't matter).

If there's a real need to special case exfat that's fine, but it might
be better to not litter special cases around if they aren't material
to the test.

also, maybe there is some risk to 2>&1 >> seqres "eating" any other
potential errors? Or maybe my bash fu is weak. ;)

I /think/ this will do the trick but give it a shot. It should filter only
the one string from stderr, and send all of stdout to $seqres.full

# Ignore permission complaints on filesystems that don't support perms
$MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2) >> $seqres.full

-Eric

> ---
>  common/rc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 9cdfe21c..2d658711 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2392,7 +2392,13 @@ _format_swapfile() {
>  	# Swap files must be nocow on Btrfs.
>  	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
>  	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
> -	$MKSWAP_PROG "$fname" >> $seqres.full
> +	if [ "$FSTYP" = "exfat" ]; then
> +		# exfat does not support posix file permisions, so warning is
> +		# to be expected
> +		$MKSWAP_PROG "$fname" 2>&1 | grep -v 'insecure permission' >> $seqres.full
> +	else
> +		$MKSWAP_PROG "$fname" >> $seqres.full
> +	fi
>  }
>  
>  # Check that the filesystem supports swapfiles
> 
