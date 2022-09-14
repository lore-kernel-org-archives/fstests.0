Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C12ECAAD3
	for <linux-fstests@archiver.kernel.org>; Wed, 14 Sep 2022 17:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiINR6A (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 14 Sep 2022 13:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiINR57 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Sep 2022 13:57:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713D083BC6
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 10:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2339DB81C4F
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 17:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F425C433D6;
        Wed, 14 Sep 2022 17:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663178275;
        bh=SId+9jEGqMMzofpdYQglRAVRH/MrpS9tPctXhOFGrZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ae4hA2Z4jd64xGJ5TSKgxaRinwxYDlOmdPXSYxA65wULy+bQF9gOpTyXpRSZv7ew7
         gZNwb7tHRhGgSC1kYdvWRUUeKIkzIcVjX4qi1zUhk/ppURm0j48debGmga7aIk4q4J
         KVSZoGKtXhUMPVsKNkcM0RjtE+Wdta6y3VgJxAPmPp9qmECNt+9cqTwxYKrACiPf++
         lgC12s00EIfgyWLV4b9D3kja2J/iB8Sn8I3BrDxn9K0yjYB5BZJbfQZZAU6An/ozKN
         xeewlEUDIgsTlZcTeXF2oIAInVJuayWu/E5BtuimCHckDnN4GwlGLSunO5Fc4JGsaW
         uQlWtOUeehFOQ==
Date:   Wed, 14 Sep 2022 10:57:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: replace obsolescent egrep and fgrep
Message-ID: <YyIWI8+OURMPIkLe@magnolia>
References: <20220913093345.84370-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913093345.84370-1-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 13, 2022 at 05:33:45PM +0800, Zorro Lang wrote:
> Due to the change in grep project:
>   a95156247098 ("egrep, fgrep: now obsolete")
> 
> some tests start to fail on latest Fedora system with grep-3.8-1.fc38
> or newer version, as:
> 
>   generic/447 70s ... egrep: warning: egrep is obsolescent; using grep -E
>   ...
>       @@ -1,4 +1,5 @@
>        QA output created by 447
>       +egrep: warning: egrep is obsolescent; using grep -E
>       ...
> 
> So use grep -E and -F to instead of egrep and fgrep commands.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  common/rc | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index a25cbcd0..dee3965e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -30,6 +30,17 @@ dd()
>  	fi
>  }
>  
> +# The egrep and fgrep are obsolescent
> +egrep()
> +{
> +	grep -E "$@"
> +}
> +
> +fgrep()
> +{
> +	grep -F "$@"
> +}

Why not conditionally define these *only* if the system doesn't already
have an egrep/fgrep binary?

(Alternately I guess you could take Murphy's patch, since that's the
proper fix according to the gnu grep maintainers...)

--D

> +
>  # Prints the md5 checksum of a given file
>  _md5_checksum()
>  {
> -- 
> 2.31.1
> 
