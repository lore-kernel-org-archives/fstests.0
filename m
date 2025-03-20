Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D901C3BF1
	for <fstests@vger.kernel.org>; Thu, 20 Mar 2025 05:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448349; cv=none; b=Ue0kLcsseY66m1Z38H6xR209JKpjs2tK7rgf+aq6cq6N08p8/RjK6Z9wU9iD0GSQfsga0Fzr99uQl7rbDWwkFqGPy4fD5pOnDRbWMcfwksHnNOuWFjfCCQZvlVKkGdTXy96h0/jTJWZ0O6FFHiwnSVaNz6+8PnwIFUfjn6ym5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448349; c=relaxed/simple;
	bh=/IVMZC0JdCML4f6zcnltifYizl4/tSkgrJ/M0x9yWK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf5ObnsfNM5/rpgYzi1nzK5/b3ScIdgePGPR1fQMnucvsxdIxl+a/k80lcQMv/rcFgztnZNFhbPOs+p3eAuTYZQltj5g7S9XHP0gT/6l/gMQFuAXgzUtV1OcLhhSOxRyc7DI4K/Laovm3BEbIBpm1IuFKpj66egsm4dlEfWFn5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgUwyPO0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgUwyPO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742448346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d92JxSfwMCDoOidXS4JBQI6YcDnhMivpcVSERaTPWNk=;
	b=cgUwyPO0bm+ktstzgX+Vvd59IjP7cU/cx+LjFGbfAaJdh0Rc6CRy9bofe5Sd36dAR/uCrg
	hDm5b4XcbXazowuKfZ3H8d4xMYTglo1ZeQ1gL43RwVoG//hYmcRKOlk+LhqCwAeOJBigTs
	29fMPc3eRICOwpWWMA1Tz8eRc427b68=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-3pxYhsL8MtWFhygq9FCjGg-1; Thu, 20 Mar 2025 01:25:44 -0400
X-MC-Unique: 3pxYhsL8MtWFhygq9FCjGg-1
X-Mimecast-MFC-AGG-ID: 3pxYhsL8MtWFhygq9FCjGg_1742448343
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso990976a91.2
        for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 22:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742448343; x=1743053143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d92JxSfwMCDoOidXS4JBQI6YcDnhMivpcVSERaTPWNk=;
        b=w2c1SNSyO0msHvN1YMeAi34+CwHFLWsVEnIhPfIlkAQ0kwNxXc/Ot1eHH3lxhUOoWJ
         lAjcsbDi4S90Wgf+6KSWzgr0P/aaCopkh9TCQFQyu+RSVeoWt7OOAC1cd4Qpyk2+cToD
         TA9Ja2oBoOOpRoH2qKfk1jyf2UQBfUgtrHWfR3uZ1D27NfLbX3WzCA5Tl1HG0gkd0emg
         Y4mDda08y2y2edZevWPkANFeTUUha0jMhtl00vpJY67ttctwJ0djZmzbkKW0vDyuOy+Z
         7AgMWt+NAxdfe5KelvNqLvJMBNFHD9ZA42JonYH93uVXDdSUtlkl3f5It7MAFF/nLLTR
         9Owg==
X-Forwarded-Encrypted: i=1; AJvYcCUauZQ9m5THtM++7aeu+kcHCPpJ47rJA24gfAMWlr8i0HxTYZLmELktw4AGwajTnolS57dyhJvo@vger.kernel.org
X-Gm-Message-State: AOJu0YxbsZdIhn5eYQhYuVyYuvFeLjsvPlVILWm3obvCSYvBOLNqlzGZ
	J+Mn+Qfng3HehsWwhQgZ4owGaIwimA6hbg68netKb9mV7X+TV0ZH4kR+/GjCUo6mTgZm4SBig3+
	gxcDuYXn0sMlRq2xkl0VRdwnnle3AVL1Lvi7FpjlFOs4M8JE1eP+Ui/o=
X-Gm-Gg: ASbGnctaIEwBbHO6DatJ9wDgSXFQf/KgBGWFHTxK1O+l3QlbDJoy2eCfPU9YCIbTuLv
	Ke3lU+atJsfmqnkgvVrPKZUXzSc2AW4E+mwIICf47gTLKurPw2VDYlxMdL3RUH8tOYDtm1sc+U4
	Yg7n/4l3NQ/xtzXmw5OBJSxuzBl+WwdOaofgKsYPQ8L18X8stAaQxU+p1oE+zXLRzuuCFZxR038
	z7+UE+attTZMqlIix9XWHEC07U93/rC76eGjWZb7OoGsGt4r1/0JcmgZp0auouZdh7FOVZvecbr
	24tdbTEx7oW7y2UlrbCOPjIr2qHOoJdCnQ8Wk0M+PMUlbpLSNjZzT2yN
X-Received: by 2002:a17:90b:224c:b0:2fe:b907:562f with SMTP id 98e67ed59e1d1-301bdf84fb6mr8955420a91.14.1742448343469;
        Wed, 19 Mar 2025 22:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1ccTWTqHNhGuAfvneFhGTmwnie2y7BAl435kmhpywLQBbXS049Bkb9z3lKcYOeIotG2QnKw==
X-Received: by 2002:a17:90b:224c:b0:2fe:b907:562f with SMTP id 98e67ed59e1d1-301bdf84fb6mr8955403a91.14.1742448343157;
        Wed, 19 Mar 2025 22:25:43 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf5a1b6bsm2804598a91.29.2025.03.19.22.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 22:25:42 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:25:39 +0800
From: Zorro Lang <zlang@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eric Sandeen <sandeen@sandeen.net>,
	Christian Brauner <brauner@kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: generic/699 fails on ext4 due to using ext4 mount options w/
 overlayfs
Message-ID: <20250320052539.k54w7kv6rz4gusu5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c46d8caf-053a-4af1-b562-7ca7203cb926@sandeen.net>
 <20250318235116.GE787758@mit.edu>
 <ffed04f3-5743-4a92-9b2c-20887c04a4cf@sandeen.net>
 <20250319151144.3r27tjgenbzty5tr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250319153902.vn3xcttrrytrkfx3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250319164410.GB1061595@mit.edu>
 <20250319200142.dmt2sz2jnotmyjeo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250319233242.GC1079074@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319233242.GC1079074@mit.edu>

On Wed, Mar 19, 2025 at 07:32:42PM -0400, Theodore Ts'o wrote:
> On Thu, Mar 20, 2025 at 04:01:42AM +0800, Zorro Lang wrote:
> > Fstests supports overlayfs testing with different underlying fs, for example
> > if you want to test overlay with ext4, you can set local.config as:
> > 
> >  FSTYP=ext4
> >  TEST_DEV=/dev/sdb
> >  TEST_DIR=/mnt/test
> >  SCRATCH_DEV=/dev/sdc
> >  SCRATCH_MNT=/mnt/scratch
> 
> Yes, I know.   My test appliances has autmation around setting local.config
> 
> > 
> > then does:
> > # mkfs.ext4 -F $TEST_DEV
> > # mkfs.ext4 -F $SCRACH_DEV
> > # mkdir /mnt/test
> > # mkdir /mnt/scratch
> > # ./check -overlay -g auto
> > 
> > For more details you can refer to xfstests/README.overlay.
> > 
> > Currently fstests only supports overlayfs testing as this, other fs, e.g. nfs,
> > has to prepare nfs SCRATCH_DEV and TEST_DEV by the user. I'm thinking about
> > supporting other upper fs testing likes overlay (if it's helpful).
> 
> I have automation that handles this, so I'm good:
> 
> ./kvm-xfstests --primary-fstype xfs -c overlay/default -g auto
> 
> My point was that might be the reason why it might be convenient for
> the test generic/699 being in generic/ instead of overlay/, since it
> means that people who are runing a large number of configs, e.g.:
> 
> ./kvm-xfstests -c ext4/default,xfs/default,btrfs/default generic/699
> 
> can easily test overlayfs with idmapping with different underlying
> file systems.  (Note: this is where my automation will write to
> local.config while iterating across different file system configs).

Yeah, that's why I left this case in generic/, I thought Christian Brauner
might want that -- "do this idmapped mount test on overlay, no matter he
tests on each kind of underlying fs". So I cc Christian Brauner, to check
if that's his purpose.

> 
> Is it worth regularly running generic/699 across multiple underyling
> file systmes?  I dunno; I'll let other people chime in on it, since I
> don't really use overayfs with idmapping myself, and I haven't
> examined the code paths in question myself.

Sure, thanks for you look into it :)

Thanks,
Zorro

> 
> Cheers,
> 
> 					- Ted
> 

