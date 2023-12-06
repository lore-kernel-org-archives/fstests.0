Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5L8GwmL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3201B12B
	for <fstests@vger.kernel.org>; Wed,  6 Dec 2023 05:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701869754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwApGcjbVB2/g9F+5sCLlB1sJOloJ8NVDY/Q5suv8LE=;
	b=B5L8GwmL7jUbHFx6VZgpaUZDiXnH1oC/Dto6zh76svyieke4pJbiwhjmTSTjevXFLMDqiY
	Va4FpSLw+TxbubAfMuV6esK57T+Al6ihgSqLIUDpW7+j110G9hx5sWC+LIvepebYFAWbE7
	CHlDDBmGOHZEwP6vWpzBaX/30wpQbh0=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-fsJqEbbuOaSntsdMjOAreQ-1; Wed, 06 Dec 2023 08:35:53 -0500
X-MC-Unique: fsJqEbbuOaSntsdMjOAreQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35d72ba9431so30687895ab.1
        for <fstests@vger.kernel.org>; Wed, 06 Dec 2023 05:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701869752; x=1702474552;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwApGcjbVB2/g9F+5sCLlB1sJOloJ8NVDY/Q5suv8LE=;
        b=JoyBwznik38Yeekk7sWmlR/PzyDfPlwXGK+EBLiGdamLRoGaNqdvBJ7w5q9d9WypJB
         HC4IiikK80twRitJZWzRTcDvwE6YqzOlYexClDrSpco0T+CTEApgoE1xaLaeOU0gQUOr
         JJ4VNHf5jPRAt7PMqAOwAwP5hLaLIjlNFNZrk4O+sbM7+WRwQgLTkfLqHsvT2lrJrKNL
         hdn17zocuieKHUSUZSC9f1nshYDy2Y6v6Menu7THF/2goFvoFIb5GYZUtwh6n/2VpMWn
         RITFc+eVc49M0vrEkL/ymvrkfAGT2hxvHRnnIF1/MAhuJrnRji7Br7dN9EoTwosGje87
         ERHQ==
X-Gm-Message-State: AOJu0YxgKg7k5h5OcMw/yCc2PNyFyvmwXcHx28Kvdax94xxns5WIcvSK
	PSz5OhoIWokBWBsL8viDxPGZrH1BF7n1bGhBPQBSleRg4SumJcHA+69q3u8nMIn55iaZ03x66cy
	ugI39njK1f/B+ly7xBMPtxMhxEj20prQ=
X-Received: by 2002:a05:6e02:1352:b0:35c:8f50:acd3 with SMTP id k18-20020a056e02135200b0035c8f50acd3mr1019944ilr.18.1701869752099;
        Wed, 06 Dec 2023 05:35:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuXQNqAztvgVUty9xiZxViYydyBcK0OkTIPlQogigBoFp4XaYTgRFyuHLCr6UcdiWL4iXeow==
X-Received: by 2002:a05:6e02:1352:b0:35c:8f50:acd3 with SMTP id k18-20020a056e02135200b0035c8f50acd3mr1019933ilr.18.1701869751813;
        Wed, 06 Dec 2023 05:35:51 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g19-20020a632013000000b005c60ad6c4absm10944080pgg.4.2023.12.06.05.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:35:51 -0800 (PST)
Date: Wed, 6 Dec 2023 21:35:47 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Larsson <alexl@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/4] overlay: prepare for new lowerdir+,datadir+ tests
Message-ID: <20231206133547.mmu32yearrpcjjdk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231204185859.3731975-1-amir73il@gmail.com>
 <20231204185859.3731975-3-amir73il@gmail.com>
 <20231206083746.aeokhhylcbpd6rkl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxi-64evfEQo3KNbO5-h1LF1Jgy5o1X1niH_EO+U7-2fHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi-64evfEQo3KNbO5-h1LF1Jgy5o1X1niH_EO+U7-2fHA@mail.gmail.com>

On Wed, Dec 06, 2023 at 12:29:54PM +0200, Amir Goldstein wrote:
> On Wed, Dec 6, 2023 at 10:37 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Mon, Dec 04, 2023 at 08:58:57PM +0200, Amir Goldstein wrote:
> > > In preparation to forking tests for new lowerdir+,datadir+ mount options,
> > > prepare a helper to test kernel support and pass datadirs into mount
> > > helpers in overlay/079 test.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  common/overlay    | 15 +++++++++++++++
> > >  tests/overlay/079 | 36 +++++++++++++++++++++---------------
> > >  2 files changed, 36 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/common/overlay b/common/overlay
> > > index 8f275228..ea1eb7b1 100644
> > > --- a/common/overlay
> > > +++ b/common/overlay
> > > @@ -247,6 +247,21 @@ _require_scratch_overlay_lowerdata_layers()
> > >       _scratch_unmount
> > >  }
> > >
> > > +# Check kernel support for lowerdir+=<lowerdir>,datadir+=<lowerdatadir> format
> > > +_require_scratch_overlay_lowerdir_add_layers()
> > > +{
> > > +     local lowerdir="$OVL_BASE_SCRATCH_MNT/$OVL_UPPER"
> > > +     local datadir="$OVL_BASE_SCRATCH_MNT/$OVL_LOWER"
> > > +
> > > +     _scratch_mkfs > /dev/null 2>&1
> > > +     $MOUNT_PROG -t overlay $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
> > > +             -o"lowerdir+=$lowerdir,datadir+=$datadir" \
> > > +             -o"redirect_dir=follow,metacopy=on" > /dev/null 2>&1 || \
> > > +             _notrun "overlay lowerdir+,datadir+ not supported on ${SCRATCH_DEV}"
> >
> > Hi Amir,
> >
> > I found overlay cases don't use helpers in common/overlay recently, always
> > use raw $MOUNT_PROG directly (not only in this patchset). Although overlay
> > supports new mount format, can we improve the mount helpers in common/overlay
> > to support that? It would be to good to use common helpers to do common
> > operation.
> >
> > Anyway, that can be changed in another patch, if it takes too much time or
> > you don't want to do it at here. What do you think?
> 
> I agree. I wouldn't improve the existing helpers to support the new
> lowerdir+,datadir+ options as positional argument like in
> _overlay_scratch_mount_dirs(), but there is an opportunity to reduce
> dedupe of this common line with a helper:
> 
> # Mount with mnt/dev of scratch mount and custom mount options
> _overlay_scratch_mount_opts()
> {
>         $MOUNT_PROG -t overlay $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT $*
> }
> 
> I will work on this cleanup and post a patch when I get to it.
> No need to block this series for the cleanup.

Agree, thanks for doing this!

> 
> Thanks,
> Amir.
> 

