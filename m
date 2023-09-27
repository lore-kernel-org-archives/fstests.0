Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF831E80AB3
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Sep 2023 14:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjI0Odu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Sep 2023 10:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjI0Odt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Sep 2023 10:33:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6F3F3
        for <fstests@vger.kernel.org>; Wed, 27 Sep 2023 07:33:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF29C433C8;
        Wed, 27 Sep 2023 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695825228;
        bh=/N9uOJ/sgcxjvntKB714ygv0FbOa/sv5Bnkel2mWVFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bn6MEyhoqemmsnTD2e+E8KwPo7oOPTTYw+be1fep34CL0j670LUNDV8Tisy/Ne3tt
         s1ZCA/ururDp3rJmCdnqcNuuknfp+dqayIB1zDBSRypIJAAHRASGuL3ncSg/H54IZW
         pMEKGffmCkM1T5AsxbwSst8HUR64UnasLTaXA45oQnvdgdSWLhoII18Gcqk3rHozQu
         16XyUCQ8npFZnrDth19S6PCUPYOqe0GpOAEEcnUPSedXaaIPPsX7BzSgiubwItHU2o
         dgEa2N1juM9TkNqS45Fi/7K8Uv6ZutGmuBb/usU3TbL/tTZBjFhu4r01SDUHBOi5w8
         42XmHbXQ/VJTg==
Date:   Wed, 27 Sep 2023 07:33:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: check error case and fail the test
Message-ID: <20230927143347.GD11423@frogsfrogsfrogs>
References: <20230927061100.95365-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927061100.95365-1-naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 27, 2023 at 03:11:00PM +0900, Naohiro Aota wrote:
> If we place /var/lib/xfstests on a read-only filesystem, commands in
> _link_out_file_named() fail to modify the files. However, they won't fail
> the test. As a result, the test case fails mysteriously with only "no
> qualified output" printed.
> 
> Fix it by checking the error case.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  common/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 76a7e7740318..4e9bd34f7772 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3431,8 +3431,8 @@ _link_out_file_named()
>  		}
>  		print $result
>  		' <$seqfull.cfg)
> -	rm -f $1
> -	ln -fs $(basename $1).$suffix $1
> +	rm -f $1 || _fail "_link_out_file_named: failed to remove existing output file"
> +	ln -fs $(basename $1).$suffix $1 || _fail "_link_out_file_named: failed to setup output file"

For the second _fail, you could improve the diagnostic output by
specifying /which/ output file couldn't be linked, e.g.

	ln -fs $(basename $1).$suffix $1 || \
		_fail "$(basename $1).$suffix: could not setup output file"

Since there's always the possibility of Weird Things happening, like
project quota ENOSPC/EXDEV failures, ro mounts, and other strange things
that might be a consequence of the file the test picked.

With that changed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  }
>  
>  _link_out_file()
> -- 
> 2.42.0
> 
