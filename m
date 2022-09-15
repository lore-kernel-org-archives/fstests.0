Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF20ECAAD3
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Sep 2022 03:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiIODks (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 14 Sep 2022 23:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiIODkZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Sep 2022 23:40:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A07D101F0
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 20:39:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12494B81D75
        for <fstests@vger.kernel.org>; Thu, 15 Sep 2022 03:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A45C433C1;
        Thu, 15 Sep 2022 03:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663213178;
        bh=vwq1vZMBoNuuxvg/yj28OKoFzbEL8dYGqaoedfMFypE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyoOF0WEoZWncPldcLTIpOLUr6NkKkF9oDabIMhMljy6bfwO/dxmIDPcRIaBLgdQe
         PMT2aFlgW5SfW3FG8IIe04DteoxHjVN1/jina58/M6USNsICdC4F9+Rft5JckJuJNb
         C2WQPwt9czeK5ohG35fM70gTXX8rihpM0Vn9llrdbnIB/BMPAE8snr9O0jB5G5T0RM
         NrEGvhz1Es8vHVI4fFmQP1aSRjDibHW37MJQyagmZ/Sj59L53/5GYkPGIwV5y4iePL
         rpmvPXnkfXKHvcL5z3RK0ir52PJKcxs292JmrmIizATt1N6MYQYMTCR2htNHV2ad3N
         m+eFl/tRxf8lQ==
Date:   Thu, 15 Sep 2022 11:39:34 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: replace obsolescent egrep and fgrep
Message-ID: <20220915033934.gncutjkjqttaocjr@zlang-mailbox>
References: <20220913093345.84370-1-zlang@kernel.org>
 <YyIWI8+OURMPIkLe@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyIWI8+OURMPIkLe@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 14, 2022 at 10:57:55AM -0700, Darrick J. Wong wrote:
> On Tue, Sep 13, 2022 at 05:33:45PM +0800, Zorro Lang wrote:
> > Due to the change in grep project:
> >   a95156247098 ("egrep, fgrep: now obsolete")
> > 
> > some tests start to fail on latest Fedora system with grep-3.8-1.fc38
> > or newer version, as:
> > 
> >   generic/447 70s ... egrep: warning: egrep is obsolescent; using grep -E
> >   ...
> >       @@ -1,4 +1,5 @@
> >        QA output created by 447
> >       +egrep: warning: egrep is obsolescent; using grep -E
> >       ...
> > 
> > So use grep -E and -F to instead of egrep and fgrep commands.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> >  common/rc | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index a25cbcd0..dee3965e 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -30,6 +30,17 @@ dd()
> >  	fi
> >  }
> >  
> > +# The egrep and fgrep are obsolescent
> > +egrep()
> > +{
> > +	grep -E "$@"
> > +}
> > +
> > +fgrep()
> > +{
> > +	grep -F "$@"
> > +}
> 
> Why not conditionally define these *only* if the system doesn't already
> have an egrep/fgrep binary?
> 
> (Alternately I guess you could take Murphy's patch, since that's the
> proper fix according to the gnu grep maintainers...)

OK, let's drop this patch, turn to review Murphy's. I just hope to avoid later
patches using egrep and fgrep commands.

Thanks,
Zorro

> 
> --D
> 
> > +
> >  # Prints the md5 checksum of a given file
> >  _md5_checksum()
> >  {
> > -- 
> > 2.31.1
> > 
> 
