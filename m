Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CECECAAD8
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Sep 2022 03:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiIWDbb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 23:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiIWDb2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 23:31:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671261166F0
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 20:31:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B79FB80E77
        for <fstests@vger.kernel.org>; Fri, 23 Sep 2022 03:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC426C433D6;
        Fri, 23 Sep 2022 03:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663903884;
        bh=ihfdosmHD3Mh/yeWpiEaaMuRvcbFeClwEEmTII+kwqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lbfmytuj9T5LLpueA0e9Hp/RlWu4sEPmC6ptGycAW0gR4E7C/GCRyLc+7geRnXJFZ
         fwE1B2DwTE2Z9NxiKXXZxMpkr0ckMRDqLcqK9SXFngXI0CpCs+CyTrm80LfYUF6PFR
         bvkFxlSPL7YM/89aWhljBjNi4+bLrA9/k9yUxQ9U+m4DhSPIZRmKmVpbqicey3Y5IG
         /nhUquZ1T/LzhQFOvtO0znVoGCrBHOgnpwvkcitZXTKafUt/8ZMp7Vrha4rXj+wC2B
         2Od4lAPShc9DFf8sjIbHngfmbjQmBwbtPbBjMmWXu4EfTlEYMnYzNNgfjjphcRyvRz
         9ucocYDijsF7A==
Date:   Thu, 22 Sep 2022 20:31:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] common: Fix file leak in _get_max_file_size
Message-ID: <Yy0oizGOSvd6Z2Yu@sol.localdomain>
References: <20220922134822.1020119-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922134822.1020119-1-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 22, 2022 at 03:48:19PM +0200, Pavel Reichl wrote:
> This is obviously mostly problematic for FS lacking support for sparse
> files.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  common/rc         | 1 +
>  tests/generic/692 | 0
>  2 files changed, 1 insertion(+)
>  mode change 100644 => 100755 tests/generic/692
> 
> diff --git a/common/rc b/common/rc
> index 228fcb37..c9078649 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4637,6 +4637,7 @@ _get_max_file_size()
>  			l=$m
>  		fi
>  	done
> +	rm -f $testfile
>  	echo $l
>  }

Removing the file is fine, but I didn't have filesystems that lack support for
sparse files in mind when I wrote this function.  Maybe it should look at $FSTYP
first, and only use the generic algorithm as a fallback for unhandled types?

- Eric
