Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0204DDA2
	for <fstests@vger.kernel.org>; Mon,  1 Jan 2024 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOOEvJsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704138932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fom98YZ3saOzfcMPCQNEio6JgkI9Tm86huiOm1TIpTI=;
	b=FOOEvJsD5/W5sxpsEoanGRrY9zorQIqesWciX01DhEHui3jEt/eosTBwAKclL00RxutOiU
	uMFYI14hFJXOW7l4HXd3oEjRNeRpaCkTdsE1ps13FojdDE9OxUbyJiWYM4kJUiUpCEyFfm
	UhEk0e52YD5z/m+KAGVQZAXzBQayujE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-aYOsoRD2OWiarBCAN7lmaA-1; Mon, 01 Jan 2024 14:55:29 -0500
X-MC-Unique: aYOsoRD2OWiarBCAN7lmaA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-595562e462cso1639867eaf.0
        for <fstests@vger.kernel.org>; Mon, 01 Jan 2024 11:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704138928; x=1704743728;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fom98YZ3saOzfcMPCQNEio6JgkI9Tm86huiOm1TIpTI=;
        b=aen97jU4tf1qJBJGioy59ofYNSmQ7BB7rc5CAx1nnTLa7ZtRtC1uQNaDclhVM1+OTS
         QWLxI0gn6yMd6PQgW4iN3pdCKaqqb+gL7YFlpA9uUt/1Ys5oVFJVJVn4/kQ0XxgpMGLr
         csNBY5SwF+ZqrdDfx9r3WCa950iuEGWyd5IwNW0S7xx8jnFN9MeA1sMfKC8W+D92/1YO
         5BnyVS9z82ZKiQiN9LTqYKZoc1AdXxYRW0qUnYdkqX/FdlICuP4svmcbeaO2oTKCKNLi
         290kMTq+kFgt+IocB7N1COJ4Tzts5RA62zq3jbigNJL5v6xravcHr8Wgv5ywAn/5O1/X
         946w==
X-Gm-Message-State: AOJu0YyCJI16znK7cseCD8tFP2gfvPaiQcWFi53l7UjuiVQHwD84usYv
	sctSwUqnFxQjz9KkmfaLgbfQRMy8A3qu/swDgoiWSkjiSakmwRJldLKXfdSWSnKYJrZ3gOSJw/u
	F6LnJZK7YU1rB+5D9GAmMb42JJA==
X-Received: by 2002:a05:6871:8210:b0:203:c722:5210 with SMTP id sp16-20020a056871821000b00203c7225210mr20073963oab.74.1704138928371;
        Mon, 01 Jan 2024 11:55:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7c8ZR8oiWnoADHUOdm4UGdpd3RniL9mcBAlHPE+kv5t/VY6J6FYaHasXWwHu8f8qoMWfzcA==
X-Received: by 2002:a05:6871:8210:b0:203:c722:5210 with SMTP id sp16-20020a056871821000b00203c7225210mr20073949oab.74.1704138928046;
        Mon, 01 Jan 2024 11:55:28 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g33-20020a635221000000b0058ee60f8e4dsm19349836pgb.34.2024.01.01.11.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 11:55:27 -0800 (PST)
Date: Tue, 2 Jan 2024 03:55:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/303: add git commit ID to _fixed_by_kernel_commit
Message-ID: <20240101195524.6pmsefq4welawfae@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <a61891b7afa408c39921c2357d00812292068c9e.1701858258.git.fdmanana@suse.com>
 <20231209044114.znk5wbl5fuwgf5hr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H53RjEXxRXC=x_H2qZ+aaeSgoikvoirBTRdDWW0nAmHzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H53RjEXxRXC=x_H2qZ+aaeSgoikvoirBTRdDWW0nAmHzw@mail.gmail.com>

On Fri, Dec 29, 2023 at 12:59:44PM +0000, Filipe Manana wrote:
> On Sat, Dec 9, 2023 at 4:41 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Wed, Dec 06, 2023 at 10:24:44AM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > The kernel patch for this test was merged into 6.7-rc4, so replace the
> > > "xxxxxxxxxxxx" stub with the commit id.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> >
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> What happened to this patch? It was not merged in the last 2 for-next
> branch updates.

Sorry, it was missed, it'll be in next release.

Thanks,
Zorro

> 
> Thanks.
> 
> >
> > >  tests/btrfs/303 | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tests/btrfs/303 b/tests/btrfs/303
> > > index b9d6c61d..521d49d0 100755
> > > --- a/tests/btrfs/303
> > > +++ b/tests/btrfs/303
> > > @@ -15,7 +15,7 @@ _begin_fstest auto quick snapshot subvol qgroup
> > >  _supported_fs btrfs
> > >  _require_scratch
> > >
> > > -_fixed_by_kernel_commit xxxxxxxxxxxx \
> > > +_fixed_by_kernel_commit 8049ba5d0a28 \
> > >       "btrfs: do not abort transaction if there is already an existing qgroup"
> > >
> > >  _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > > --
> > > 2.40.1
> > >
> > >
> >
> 

