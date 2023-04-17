Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B1DC77B76
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Apr 2023 17:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDQRUb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Apr 2023 13:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjDQRUa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Apr 2023 13:20:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BAFA5D4
        for <fstests@vger.kernel.org>; Mon, 17 Apr 2023 10:20:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-506b2a08862so384047a12.3
        for <fstests@vger.kernel.org>; Mon, 17 Apr 2023 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681752002; x=1684344002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAjJ7fsw1baMcvYkROYwAezjzyqTLBZPQIKeC6DMbDE=;
        b=nCM7YVxfYXIJYbasNcvG51xjEX31TaKPF6Xi0jagpcAS44LH3wO6NiRShDSLWnhhAG
         od1uqApRKudFCIN4GtvMn2ymkfIlgaKATlfj5elZU+D/71eHwHMujid1jZdQkRYhF9iP
         khKjVfGsLO+QKBUoanSdFjFfPBVX55RbKE2Z4apnhTy+U1gBdg8aCqQEqtfFqntoQrsH
         j6OmumsvqhdbQ8FNqFcntWCpoFp7iSR/bIBiFjyLI6Wth/VZk0USE5XGUHVfi/+pONjb
         ApQ5JPK1p/ZErSwzX37gzrjn7/pXuqdWnknau1bfdm2BLMCCFnh5Ecb1Gv/dDUOLB1eT
         UqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681752002; x=1684344002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAjJ7fsw1baMcvYkROYwAezjzyqTLBZPQIKeC6DMbDE=;
        b=dPIbd9ldVBy4gBwcbJKJqPu47xczf3lz6Kv1jwKwAHS2GLzVsXcNOry7JthKlq204j
         RLfC/vOzAcLArGTOXbGWRsNYaJUe7EZVxlMuMbMj/dv69xdpZ9sl+H24r0Q70W1PARX2
         OoTZEixoB6Y62sRjaBbbv+RWcGrm4a57umIWWTQdqzR48WhxqaZYWsjAXarAW2BZjVd0
         RoWvTVjYb8GknpcfslEjEmH1duDTM0VLTBzdRC2NtImhcHZRt0ETuEu5h6Zgf1/BgWj0
         N0AiU67fs8pIm2mGH6Ui+s9uCF37dvImI9qKFYHZdrkDAFbjXwFdAfijZ5Fq8rmsQ6zX
         wZUw==
X-Gm-Message-State: AAQBX9dvZPWeb4XevrI0+WUNWRzaX/9ZnfwwuLWSoa+e717RduP6TbYA
        PqCS5vOP0hlc9mkzGViZkDEUBH97SwRUCrvIpJ0fMQ==
X-Google-Smtp-Source: AKy350Zc3JftionVcDCKfHHxpr3vPSqEciwVSrCM0PLyMGXtWTHfIx11Ss6MJT314ceBbIl9zl+KEodqdNj5eov4Rzg=
X-Received: by 2002:a50:bb2e:0:b0:506:76a2:43dc with SMTP id
 y43-20020a50bb2e000000b0050676a243dcmr6948416ede.4.1681752001806; Mon, 17 Apr
 2023 10:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230414221133.3431400-1-leah.rumancik@gmail.com>
 <20230414221133.3431400-2-leah.rumancik@gmail.com> <20230415004131.GC360885@frogsfrogsfrogs>
In-Reply-To: <20230415004131.GC360885@frogsfrogsfrogs>
From:   Leah Rumancik <lrumancik@google.com>
Date:   Mon, 17 Apr 2023 10:19:25 -0700
Message-ID: <CAMxqPXVGGOn6A5ijRwaw7k0JfYD2gHftDWOVBVq=jrE3JW9gDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] check: _check_filesystems for errors even if test failed
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>, fstests@vger.kernel.org,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Sure, will send out another set. Thanks!

On Fri, Apr 14, 2023 at 5:41=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Apr 14, 2023 at 03:11:33PM -0700, Leah Rumancik wrote:
> > Previously, we would only run _check_filesystems to ensure that a test
> > that appeared to pass did not have any filesystem corruption. However,
> > in _check_filesystems, we also repair any errors found in the filesyste=
m.
> > Let's do this even if we already know the test failed so that subsequen=
t
> > tests aren't affected.
> >
> > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > ---
> >  check | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/check b/check
> > index befbf465..c18f02ca 100755
> > --- a/check
> > +++ b/check
> > @@ -972,6 +972,7 @@ function run_section()
> >                       # Even though we failed, there may be something i=
nteresting in
> >                       # dmesg which can help debugging.
> >                       _check_dmesg
> > +                     (_adjust_oom_score 250; _check_filesystems)
>
> Seeing as the test failed, do we care about the state of the scratch fs?
> Would it be sufficient only to clean up the test fs to avoid cascading
> damage?
>
> (Asking as someone who knows how impactful slow filesystem checking can
> be on fstests runtimes... ;))
>
> --D
>
> >                       tc_status=3D"fail"
> >               else
> >                       # The test apparently passed, so check for corrup=
tion
> > --
> > 2.40.0.634.g4ca3ef3211-goog
> >
