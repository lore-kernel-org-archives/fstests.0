Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B926BC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Dec 2021 00:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbhLPAyY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Dec 2021 19:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLPAyY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Dec 2021 19:54:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B40C061574
        for <fstests@vger.kernel.org>; Wed, 15 Dec 2021 16:54:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 467C9B82232
        for <fstests@vger.kernel.org>; Thu, 16 Dec 2021 00:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01803C36AE0;
        Thu, 16 Dec 2021 00:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639616061;
        bh=nLltFXYGUWQiNCslbwqyj3tbgFocg47gzUby4oNBH3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZniuPl2ptnujB49vdFrCOltAPZ+gKfc5uYT7CBYqg7FMDLIkJQLD+YblBO0hu7Iq
         CHVIfWVP2Hm6XJYd+1ISIu74Gbx9XuRXtR3AHPp0F1IDWrK0AlgZUzkK7mXOn8rl14
         W7Hx1PkCEoEq37LYLxITxJDMOixcy4aD7UVPxHC1dZE64NUf4BeJY1PF179jXtClkv
         M+blJ9k7VsgBdpkONdz584V1EAgeb67CTAbmdBckyH82ck6YFFov0oZoa+p/5BBnPj
         pSSQJMm2Ng+2Ee0NPCOuaDUnNlc5bC30yduM0T+P3NqADO/6iVAL5Sn5bUEp6W9DXm
         dUvnfabMLKU+w==
Date:   Wed, 15 Dec 2021 16:54:19 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/filter: add _filter_bash()
Message-ID: <YbqOO74Lfer5h33Y@sol.localdomain>
References: <20211214170438.16164-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214170438.16164-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Ted,

On Tue, Dec 14, 2021 at 12:04:38PM -0500, Theodore Ts'o wrote:
> This is needed to account for bash 5.1 adding line number annotation
> when a command like "bash -c /etc/passwd" fails, e.g., with
> 
>      bash: line 1: /etc/passwd: Permission denied
> 
> instead of:
> 
>      bash: /etc/passwd: Permission denied
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  common/filter     | 11 +++++++++++
>  tests/generic/572 | 33 +++++++++++++++++++--------------
>  2 files changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index 2efbbd99..4b250e8b 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -661,5 +661,16 @@ _filter_quota_report()
>  		s|^(.*?) (\d+) (\d+) (\d+)|$1 @{[$2 * 1024 /'$bsize']} @{[$3 * 1024 /'$bsize']} @{[$4 * 1024 /'$bsize']}|'
>  }
>  
> +#
> +# Bash 5.1+ adds "line 1: " when printing an error running an executable
> +# for example, "bash -c /etc/passwd" will result in the error
> +# "bash: line 1: /etc/passwd: Permission denied" where as earlier
> +# versions of bash will omit the "line 1: " annotation.
> +#
> +_filter_bash()
> +{
> +	sed -e "s/^bash: line 1: /bash: /"
> +}
> +

Doesn't this happen with any shell command passed to -c, not just commands that
run an executable?  In the commands below which are causing the problem, it is
actually the 'echo' built-in being used, not an executable.

> -bash -c "echo >> $fsv_file" |& _filter_scratch
> +bash -c "echo >> $fsv_file" |& filter_output
>  echo "* bash >, should be O_WRONLY|O_CREAT|O_TRUNC"
> -bash -c "echo > $fsv_file" |& _filter_scratch
> +bash -c "echo > $fsv_file" |& filter_output

Otherwise this patch looks good, thanks!

- Eric
