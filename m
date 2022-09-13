Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0E5C54EE9
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Sep 2022 12:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiIMMxI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Sep 2022 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiIMMxH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Sep 2022 08:53:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6147C51419
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 05:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8CE261466
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 12:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD7DC433D6;
        Tue, 13 Sep 2022 12:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663073583;
        bh=20V9JMd8t2M6Turr5Ulnau31s/S4gZKwB0o7NaWXnDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O8+cXsvFezf68ds92mo9Ym2iLaceN5w/9k4H6CR7xLcs5HSBCTFQvNoY62Yn6gmx5
         UBhHdUWfY7kvc8C24T8yFH8XIKlQ54P6dqeeDiEM9zEsxnkZYpF7BLKIpQZUIc0mE4
         T1l2uNCOQjp99T0ucJUGJQ7iHdHOamoXrENW3S0rdvULFN01yYbP2nOSwxZghW3WVf
         W48wgKYgQ4i1EzfYK7uwGAvFoG+GdvctuTFbhij9eTVFcgofJU/b+fBu8v00Gucrsm
         G+y+vXcMSTT/nT5GZx6RKoOAxwVTNHbX9c1gXSkI36ySRifU6NxwaqwQ0DhJNTMeJU
         1I3FQV5FKQXKg==
Date:   Tue, 13 Sep 2022 20:52:58 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: replace obsolescent egrep and fgrep
Message-ID: <20220913125258.exj4iszolctiuxv2@zlang-mailbox>
References: <20220913093345.84370-1-zlang@kernel.org>
 <20220913142751.2d4026d9@echidna.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913142751.2d4026d9@echidna.suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 13, 2022 at 02:27:51PM +0200, David Disseldorp wrote:
> On Tue, 13 Sep 2022 17:33:45 +0800, Zorro Lang wrote:
> 
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
> > +
> >  # Prints the md5 checksum of a given file
> >  _md5_checksum()
> >  {
> 
> Nit: AFAICT there's only one fgrep caller, so just change that single
> case. With that fixed:

Thanks for reviewing!

Yeah, I thought about that too. But then I thought a fgrep() might help later
patches to avoid using fgrep command directly, so ...

Thanks,
Zorro

> 
> Reviewed-by: David Disseldorp <ddiss@suse.de>
> 
