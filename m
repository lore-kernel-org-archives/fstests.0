Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F4280A35
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413567; cv=none; b=HR9u1JTt2KZqfJlkEOTprTsWRTEaEycJib+lHv8dOtOV7TGbGnCjuKERVXOdtk42Xca7bIwMBN/DnXQBskpH78629oOP4evivDRa3Tx/mOWEEY3tZvBbfIhLVhD1pc7Lw9TbQmc+ha4Om0oU/EsY6OpBZJI9ODQMOG6AIKIDHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413567; c=relaxed/simple;
	bh=OzVbpjI8C6JTha7ddFw5nS3D/50BZY32rnlkq7C43LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdhhjjGpNyYQCbyVjCzfzhJaSSQ+XSc3h97K/n92M8iqNY31+Wc0MlkrBu8YqDXcBWh5dEF53XTGXM96oikVydQ9v7WUTIXuqYrzSs4Qkutd7NyeG5zjrPpG3xYhBrVYSVP7xrKaDl7SgMfIgqufAZAVp14FPNuTZCW6dwpgojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTe0N6uQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTe0N6uQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750413564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dfszn5yGEBNpQXiNBQPNMo3E2l6PzQ3VV8xBzk6sGCk=;
	b=MTe0N6uQxWgEN0P/oKxzuYzTxJIS1muwF/pMutV6dVnq/WiRykgDsb5w2vSCC2v6ncWqH7
	EN+p2j+u0I++HfbfGpCw0JAaffjZdcGKcq9fcTinOGr8JQ0ZArkwsGR9CzZWmrys2qmCkH
	elLOqwnBi2Ck6E5tehA9+QOQjQj61Zw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-KuaSOyY7NgiAwKnU2UAGIw-1; Fri, 20 Jun 2025 05:59:23 -0400
X-MC-Unique: KuaSOyY7NgiAwKnU2UAGIw-1
X-Mimecast-MFC-AGG-ID: KuaSOyY7NgiAwKnU2UAGIw_1750413562
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235dd77d11fso17802945ad.0
        for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 02:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750413562; x=1751018362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dfszn5yGEBNpQXiNBQPNMo3E2l6PzQ3VV8xBzk6sGCk=;
        b=eCHVZo93SYa46zOcjMuA5l2naiLSLqQz0kOQ9jodz83OZHNUduaGiBMykrNgrtfUqV
         uWPG2pEAi5mgzRcBn6g2l89tN3ki7b4ebiMS0kWxgUksrYsMWVjnrmnU0K7V8UTe/j5P
         IPZWarYTj/sOnYI9lID3caPv/knPpyRCI2GKZYwUn+N/iTIWWhhjX3l4hTtDfIg45sJK
         AuQtDtI+Fzvk3apjAEEM+nN8+u2TbtmiGasZbuQ0iEPhyFQBI7FEo0UvWMlhbK446bFk
         KxxhgIh2/4Q9ApCw9JdoTui7LTDTw23J2sDXL/TEjMA1jh5E9/M1eVkP4UDuurbBUvRp
         4g3A==
X-Gm-Message-State: AOJu0YxNj+0IyKPSK8KLIgtsNUPYqt86KxtCBL87m0TgEKtg5umX0V7a
	42Das2/B/CD3CukNMirxeOupAafZ7z1kcWh0kFhQlZNf1oW3j0i3nXI3eEppY8g75BkLDzgH/4R
	0juJ1bP/ZNf/b1Z+KDL8wEOvtkt2tuXPXChZ/m7X/S/DY2gRuS1MM9zzkWTo=
X-Gm-Gg: ASbGnctoTOhkLUQIgzxNnVpEF5b98B0++6p6O4650Guze6BDYNnqIxy7qUCT3L6oNUn
	DtKc79TuGkWTceTL5BwTcyl+X727ektK//9jdKn8TtFesqmOKLtGsGKG21H6a3USwpwFOBpmob0
	78wO4ZPEPvpRM5eQCYTyECD26OMceo16hAjcLfngRTMyuzTg8/EE8orEYBbG+QI2T19J19h2YWH
	nqwz30fAfxKFurGBSTgdyiWfJwISfZb1AB84Kzv41LuSKPrqAA5dEtNG4euj3WJy5SIiEB4sAv5
	Se09QnMAgTg3QD1nAN5tDtGEmRIzg4fbLsOrk6WDjdwTyyjLbzFN5mu02nEocAk=
X-Received: by 2002:a17:902:f546:b0:235:1171:6d1d with SMTP id d9443c01a7336-237d9778c44mr31617055ad.9.1750413561928;
        Fri, 20 Jun 2025 02:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe6z1jCt9P29nd5bUp1KMM+UoUc1b4iN34jdhHXF/ipj6Fp8eU7N6oZJoYF8siY9bRNwkuGw==
X-Received: by 2002:a17:902:f546:b0:235:1171:6d1d with SMTP id d9443c01a7336-237d9778c44mr31616645ad.9.1750413561369;
        Fri, 20 Jun 2025 02:59:21 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d861061dsm14099045ad.118.2025.06.20.02.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 02:59:20 -0700 (PDT)
Date: Fri, 20 Jun 2025 17:59:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com,
	linux-ext4@vger.kernel.org
Subject: Re: [RFC 01/12] common/preamble: Fix fsx for ext4 with bigalloc
Message-ID: <20250620095916.j4vybkssyglixae7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <2568ed1e9d1c47d0fdb357f0e10c5ed341a72379.1749629233.git.ojaswin@linux.ibm.com>
 <20250618191324.fpwyi6acobodmyit@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aFT9soHgXs1Yb5Jw@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFT9soHgXs1Yb5Jw@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Fri, Jun 20, 2025 at 11:51:07AM +0530, Ojaswin Mujoo wrote:
> On Thu, Jun 19, 2025 at 03:13:24AM +0800, Zorro Lang wrote:
> > On Wed, Jun 11, 2025 at 03:04:44PM +0530, Ojaswin Mujoo wrote:
> > > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > > 
> > > Insert range and collapse range only works with bigalloc in case
> > > the range is cluster size aligned, which fsx doesnt take care. To
> > > work past this, disable insert range and collapse range on ext4, if
> > > bigalloc is enabled.
> > > 
> > > This is achieved by defining a new function _setup_fs_options
> > > which can serve as a mechanism to apply FS-wide options to
> > > the tests.
> > > 
> > > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  common/preamble | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/common/preamble b/common/preamble
> > > index ba029a34..2bccff74 100644
> > > --- a/common/preamble
> > > +++ b/common/preamble
> > > @@ -24,6 +24,20 @@ _register_cleanup()
> > >  	trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
> > >  }
> > >  
> > > +# setup FS options only to be available for each test run
> > > +_setup_fs_options() {
> > 
> > If this's a function for fsx only, better to name it with "fsx", e.g.
> > _setup_default_fsx_avoid (or some other names).
> > 
> > > +	case "$FSTYP" in
> > > +	"ext4")
> > > +		if [[ "$MKFS_OPTIONS" =~ bigalloc ]]; then
> > > +			export FSX_AVOID="-I -C"
> > 
> > Hmm... I'm also wondering if this's an issue should be fixed in fstests. How about
> > let the testers who tests ext4 with MKFS_OPTIONS="-O bigalloc" write local.config
> > as below?
> > 
> > [ext4-bigalloc]
> > ...
> > MKFS_OPTIONS="-O bigalloc"
> > FSX_AVOID="-I -C"
> > 
> > Thanks,
> > Zorro
> 
> Hey Zorro, 
> 
> Basically the idea is that _setup_fs_options is a generic function that
> can be used to do any fs specific modifications to the global options.
> 
> This way we can set options to avoid known issues with different FSes,
> which can otherwise confuse the user if they are not aware of such
> issues. 
> 
> Does that sound okay?

I think we should give this choice to the user or the test case who wants
to test ext4 bigalloc feature. And MKFS_OPTIONS isn't the only way to
enable bigalloc, some test cases can do _scratch_mkfs "-O bigalloc".

**But, if *ext4 list* really hope to force set FSX_AVOID="-I -C" for
"$MKFS_OPTIONS" =~ bigalloc, then better to do this in _run_fsx* function at
first, I don't think it's worth having a global _setup_fs_options, and call
it at the beginning of each case running for now.

Thanks,
Zorro

> 
> Regards,
> ojaswin
> 
> > 
> > 
> > > +		fi
> > > +		;;
> > > +	# Add other filesystem types here as needed
> > > +	*)
> > > +		;;
> > > +	esac
> > > +}
> > > +
> > >  # Prepare to run a fstest by initializing the required global variables to
> > >  # their defaults, sourcing common functions, registering a cleanup function,
> > >  # and removing the $seqres.full file.
> > > @@ -55,4 +69,6 @@ _begin_fstest()
> > >  	# remove previous $seqres.full before test
> > >  	rm -f $seqres.full $seqres.hints
> > >  
> > > +	# setup filesystem options for a given test execution
> > > +	_setup_fs_options
> > >  }
> > > -- 
> > > 2.49.0
> > > 
> > > 
> > 
> 

