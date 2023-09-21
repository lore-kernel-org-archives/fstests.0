Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC99E71096
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Sep 2023 17:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjIURIB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Sep 2023 13:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjIURHf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Sep 2023 13:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1154EC8
        for <fstests@vger.kernel.org>; Thu, 21 Sep 2023 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695315732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4WlPd/L6GEeuEgDQfu7NN6MoTsebwH3J/fmzWCr2UJc=;
        b=UZPpI1UJrKRWUNNUF+Uuj8CNPAPsibJE3FWi3mike5z96wEVeTWLFaOosPZjSVEi1e76gU
        MZby5Dh71nKeyXthqOSvIr3GkDZTi+l2EtEIgN5BJ0rukHuftbdIFLwIjxieMoU4qgDoFG
        zET6kkdeSdghZ2n2hl1BJjT3g3z9jc0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-h8k61Y9cO66QB4dn5MrKIg-1; Thu, 21 Sep 2023 12:23:24 -0400
X-MC-Unique: h8k61Y9cO66QB4dn5MrKIg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c46ce0c39fso9213075ad.2
        for <fstests@vger.kernel.org>; Thu, 21 Sep 2023 09:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695313404; x=1695918204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4WlPd/L6GEeuEgDQfu7NN6MoTsebwH3J/fmzWCr2UJc=;
        b=te8zzlcQhQAgxEkgIb4HFZw5qXTmuxluYvf6/jfa/UffmRzMqDf7edYQzcwrnG8gMY
         ZA3LfZnLy7Me4DwoKpgz3Jto1YbCWh4NDy2vKoT75ndLj5j0KvQ4O+kb3MvMqyoiWl2r
         VvYF9cQpbUgx5alSeO7QgkKfj/s+GJgbl98f0Hnmu8W+qbc2nVJAWTrqMURKAqPGsR/Z
         +8bE8N8ORlj+t72nrtSB0KaHcolb/P04XooKduIEh9uKM82LUvoEHbzHqNTfrHds8w90
         gszDCsTs+O0tjAkp1PDwWRk0I3o6U2iXq/lLmLXkN/4L0Rsf39SubsJrKvkd9XZSeTDm
         C8/Q==
X-Gm-Message-State: AOJu0Yz4uGGF9GU/d+L/o8I20iHM2SKp9cwiLKYbSYwyVFzg62KOok5b
        hq1JJFvQAiUoQ0h42vdvBK/a1RmmTAVSBMu94TcwrSBo670YTtmsj439JuqAf6Cn9LukUgNEkoC
        Gx3dO5djqj402yTCcbA==
X-Received: by 2002:a17:902:7c82:b0:1c0:aca0:8c2d with SMTP id y2-20020a1709027c8200b001c0aca08c2dmr4315982pll.67.1695313403738;
        Thu, 21 Sep 2023 09:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtHPBnEwQi7PebkVvMmm4AVgU8aYiqtveBFfMk7Kw27T0jdbgfH3w8U+JDMynC8zDOZ3F3Gw==
X-Received: by 2002:a17:902:7c82:b0:1c0:aca0:8c2d with SMTP id y2-20020a1709027c8200b001c0aca08c2dmr4315974pll.67.1695313403423;
        Thu, 21 Sep 2023 09:23:23 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902d38200b001ab2b4105ddsm1714089pld.60.2023.09.21.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 09:23:23 -0700 (PDT)
Date:   Fri, 22 Sep 2023 00:23:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Ruiwen Zhao <ruiwen@google.com>, linux-unionfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] common: add helper _require_chattr_inherit
Message-ID: <20230921162319.gsh5is3vkptp5hz2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20230921143102.127526-1-amir73il@gmail.com>
 <20230921143102.127526-2-amir73il@gmail.com>
 <20230921152648.25wd4gqralgiuksv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxj5YR4Kv2-EZXnQGDo1zbExKZ+mw=rYNVBpCo30KkFAfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj5YR4Kv2-EZXnQGDo1zbExKZ+mw=rYNVBpCo30KkFAfQ@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 21, 2023 at 06:40:49PM +0300, Amir Goldstein wrote:
> On Thu, Sep 21, 2023 at 6:26 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Thu, Sep 21, 2023 at 05:31:01PM +0300, Amir Goldstein wrote:
> > > Similar to _require_chattr, but also checks if an attribute is
> > > inheritted from parent dir to children.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  common/rc | 52 +++++++++++++++++++++++++++++++++++++++++++---------
> > >  1 file changed, 43 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/common/rc b/common/rc
> > > index 1618ded5..00cfd434 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -4235,23 +4235,57 @@ _require_test_lsattr()
> > >               _notrun "lsattr not supported by test filesystem type: $FSTYP"
> > >  }
> > >
> > > +_check_chattr_inherit()
> > > +{
> > > +     local attribute=$1
> > > +     local path=$2
> > > +     local inherit=$3
> >
> > As I understand, this function calls _check_chattr_inherit, so it will
> > return zero or non-zero to clarify if $path support $attribute inheritance.
> > ...
> >
> > > +
> > > +     touch $path
> > > +     $CHATTR_PROG "+$attribute" $path > $tmp.chattr 2>&1
> > > +     local ret=$?
> > > +     if [ -n "$inherit" ]; then
> > > +             touch "$path/$inherit"
> > > +     fi
> >
> > ... but looks like it doesn't, it only create a $inherit file, then let the
> > caller check if the $attribute is inherited.
> >
> > I think that's a little confused.
> 
> I agree.
> 
> > I think we can name the function as _check_chattr()
> 
> I agree.
> 
> > and the 3rd argument $inherit as a bool variable, to
> > decide if we check inheritance or not.
> >
> 
> Not my prefered choice.
> 
> > Or you'd like to have two functions _check_chattr and _check_chattr_inherit,
> > _check_chattr_inherit calls _check_chattr then keep checking inheritance.
> >
> > What do you think?
> 
> I think this is over engineering for a helper that may not
> be ever used by any other test.
> 
> Suggest to just change the name to _check_chattr()
> to match the meaning to the return value.
> 
> The 3rd inherit argument just means that we request
> to create a file after chattr + and before chattr -,
> so that the caller could check it itself later.

I still think it doesn't make sense ... but I don't want to give you
that pressure, so ...

> 
> If you accept this minor change is enough
> can you apply it yourself on commit?

... If you think it's too complicated, we can drop the inheritance checking
common helper. Just change the _require_chattr(), make it to accept one more
*directory* argument (use $TEST_DIR by default). Then we can do:

_require_chattr A $BASE_SCRATCH_MNT
_require_chattr A $SCRATCH_MNT

And then do all inheritance checking in the overlay case itself (likes you did in
V1), don't make them to be a common helper. Due to only this case need the
_require_chattr_inheritance, so we can think about that common helper when more
cases need that :)

I think this change is simple enough (base on your V1 patch). Is that good to
you :)

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 

