Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16424C83F12
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Aug 2023 19:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjH1TQB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Aug 2023 15:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjH1TPx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Aug 2023 15:15:53 -0400
Received: from sandeen.net (sandeen.net [63.231.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C65D9107
        for <fstests@vger.kernel.org>; Mon, 28 Aug 2023 12:15:50 -0700 (PDT)
Received: from [10.0.0.71] (liberator.sandeen.net [10.0.0.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id F35BD444F;
        Mon, 28 Aug 2023 14:15:49 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net F35BD444F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
        s=default; t=1693250150;
        bh=ETEKufNS6iaiM19/JquTRvtzZ+BJ5eCGx+AgN5+tae4=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=CX0YjypnUayhHwVFJBsXDv/W0swEBlsqIFaUA/Pii1kSFFThEM3eKCwRuZZmCrfZ2
         GMlrQcee6IpmcLG4536sXPLGb5xsN19ri3C+vGJlRK0akd3c6PaJJAKcMb4ZGigbWE
         7EMEnyI5QZeCsQGDHY6twG72tK1TwIIbBdxbH6DeNz98SKd9X1S2qwKwuIJg0XmAPz
         b77OQDZfQGuTHYuqVK1RW8Md39HqHQ2iQnt2E1//5VTzexZ0KovweeUcGCEcTUtirE
         tYi5G1GnzyxpGbWZWUL2BZX6JWH5I6LZTJftcMewnsaqiyBO/XEaKT1wDIqeXOAWRx
         1mtq45/Y3n6pA==
Message-ID: <3d0fa237-496c-662b-ec05-1135845d3ad8@sandeen.net>
Date:   Mon, 28 Aug 2023 14:15:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3] fstests: generic/352 should accomodate other pwrite
 behaviors
Content-Language: en-US
To:     Bill O'Donnell <bodonnel@redhat.com>, fstests@vger.kernel.org
References: <20230828172307.7497-1-bodonnel@redhat.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
From:   Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20230828172307.7497-1-bodonnel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 8/28/23 12:23 PM, Bill O'Donnell wrote:
> xfs_io pwrite issues a series of block size writes, but there is no
> guarantee that the resulting extent(s) will be singular or contiguous.
> This behavior is acceptable, but the test is flawed in that it expects
> a single extent for a pwrite.
> 
> Modify test to limit pwrite and reflink to a single block.
> 
> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>

This looks good to me, thanks.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  tests/generic/352     | 10 ++++++----
>  tests/generic/352.out |  6 ++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/generic/352 b/tests/generic/352
> index 52ec4850..acc17dac 100755
> --- a/tests/generic/352
> +++ b/tests/generic/352
> @@ -28,14 +28,16 @@ _require_xfs_io_command "fiemap"
>  _scratch_mkfs > /dev/null 2>&1
>  _scratch_mount
>  
> -blocksize=$((128 * 1024))
> +blocksize=$(_get_file_block_size $SCRATCH_MNT)
>  _require_congruent_file_oplen $SCRATCH_MNT $blocksize
>  file="$SCRATCH_MNT/tmp"
>  
>  # Golden output is for $LOAD_FACTOR == 1 case
> +# and assumes a normal blocksize of 4K
>  orig_nr=8192
> -orig_last_extent=$(($orig_nr * $blocksize / 512))
> -orig_end=$(($orig_last_extent + $blocksize / 512 - 1))
> +orig_blocksize=4096
> +orig_last_extent=$(($orig_nr * $orig_blocksize / 512))
> +orig_end=$(($orig_last_extent + $orig_blocksize / 512 - 1))
>  
>  # Real output
>  nr=$(($orig_nr * $LOAD_FACTOR))
> @@ -43,7 +45,7 @@ last_extent=$(($nr * $blocksize / 512))
>  end=$(($last_extent + $blocksize / 512 - 1))
>  
>  # write the initial block for later reflink
> -_pwrite_byte 0xcdcdcdcd 0 $blocksize $file | _filter_xfs_io
> +_pwrite_byte 0xcdcdcdcd 0 $blocksize $file > /dev/null
>  
>  # use reflink to create the rest of the file, whose all extents are all
>  # pointing to the first extent
> diff --git a/tests/generic/352.out b/tests/generic/352.out
> index 4ff66c21..454ff52f 100644
> --- a/tests/generic/352.out
> +++ b/tests/generic/352.out
> @@ -1,5 +1,3 @@
>  QA output created by 352
> -wrote 131072/131072 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -0: [0..2097151]: shared
> -1: [2097152..2097407]: shared|last
> +0: [0..65535]: shared
> +1: [65536..65543]: shared|last

