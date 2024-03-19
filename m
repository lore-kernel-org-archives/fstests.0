Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F2E7C0AA
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 04:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710821806; cv=none; b=aDA22ysIOexnYRSM9J2naVUBVehpipnHwXad/R2Q2CAvb4A2XGHUUGsO92mNwgzqBXX/5oKhKRses+712H1hVzIoXB2O0ZmFxvtnuWGQ4pmmCj/EH3tt6dAJGDpbxNRMD4wkgxUqRVo+aL+9t0m3ER5fydndWnMZT+cyqn8r/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710821806; c=relaxed/simple;
	bh=oBUFix4xJ9HmyXtK0FS0msR1Uprvu8MvzrmK3K0DUcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bixXvyamLv37itwEzWc+qEPwwnj8J+60S34/2XV3rPX5Hn3nF4U1yhjjO4ABNSkxH4mG8x8hgxOTyxaCckzm3Es7ooERvs7lL75hfixMPQGGyzPbgjpTT0Ac+RtYSM9MLtp5d5ZrtByhetZwZWvWYm+ozOElp5WEbeIf6w1lQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBrWqd+t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBrWqd+t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710821800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cFtfNnxEJ01CephbW6v2igIJA6n9Y9cgi1+keL4pqM=;
	b=IBrWqd+tm0dV0Puo/dZ6lTwhl7uikaFzpNCPzUts73SDkVPGlBvEBuRmpkvNUADjk92dcn
	hMexHChJj3t4bpTHaN07grLhGv+td8U8Qr0JIUPUdpj3iEGRRHKMgwF7QLc2Um7HVT5O2l
	Jfr3A6fTskyv5/FiyZmzVCmSiMbyJWA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-SvsDY94PPKWQtxdh1SG9lg-1; Tue, 19 Mar 2024 00:16:38 -0400
X-MC-Unique: SvsDY94PPKWQtxdh1SG9lg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e004445facso19040095ad.1
        for <fstests@vger.kernel.org>; Mon, 18 Mar 2024 21:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710821797; x=1711426597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cFtfNnxEJ01CephbW6v2igIJA6n9Y9cgi1+keL4pqM=;
        b=A2obr0BFAC1wvMJbpfct+N/YQjYOl+pFwBk6CKCOujHBsQNbaudsKT3BcBYtTFXefH
         B3rB9f66+M8knTNsEfeD7DaJ7u+UMW/+ncSDJTQDeezXaLViXZNm+7JZCIKd32ewUh+K
         T1HVMjBQW6xPx+ntkLnPFK7dnPtKfVnEQnzM8aFJ1gME/LHHAHIi5Pc4DhIWO4IStL6t
         AYy8O0qMcBOSWeDMtJtI9eiHclyUR5ytEXE2bqQVVFiE7v4LpeplcFVlOafIhQECjIEW
         3ZI/DdfYw6koBa3ZujYlVKrOz97V/TSuhY4sOqmwpMBVjfZSxgAL7w3fbEOMIQbpcV/S
         swKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwcET7GdS9KMe+m42nEOd0HVUk8lypShzRZpqTQVB3iWJ+MvWQB8EV/aUriLdiHr76pdub+UyvP6E6cjhxaLqBh+Dq/piRcQ==
X-Gm-Message-State: AOJu0YztSiFof/qLQHdBmV+1V5ccK6Ny6NRXjDx+OR0EY1/bCAMNX+R4
	OBvf5dCz1M+LVWuNlXelM6BNXANn370xC7+koFLhxHn0gNyGczfxnQ4rzp2fmxa3S0PeCsr0O7c
	CpzAxYevsOgg4LrW39fhhQtfJME6rSBeRPu0xK/K4oUTerFubfogSTwk=
X-Received: by 2002:a17:903:28c7:b0:1e0:16e0:b28e with SMTP id kv7-20020a17090328c700b001e016e0b28emr1771083plb.34.1710821797370;
        Mon, 18 Mar 2024 21:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXqPBbawYv4+8ogQd1QC/W45is8KfuwC92ZEvUpNhC7nvb5U26hp8nT3MoMN1hCB0pmM35Cg==
X-Received: by 2002:a17:903:28c7:b0:1e0:16e0:b28e with SMTP id kv7-20020a17090328c700b001e016e0b28emr1771060plb.34.1710821796769;
        Mon, 18 Mar 2024 21:16:36 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t188-20020a625fc5000000b006e6f8e9ab6asm7247539pfb.15.2024.03.18.21.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 21:16:36 -0700 (PDT)
Date: Tue, 19 Mar 2024 12:16:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: Re: [PATCH v2 1/2] shared: move btrfs clone device testcase to the
 shared group
Message-ID: <20240319041633.l75ifryeidjxltat@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1710599671.git.anand.jain@oracle.com>
 <440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com>
 <20240318220219.GI16737@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318220219.GI16737@twin.jikos.cz>

On Mon, Mar 18, 2024 at 11:02:19PM +0100, David Sterba wrote:
> On Sat, Mar 16, 2024 at 10:32:33PM +0530, Anand Jain wrote:
> > Given that ext4 also allows mounting of a cloned filesystem, the btrfs
> > test case btrfs/312, which assesses the functionality of cloned filesystem
> > support, can be refactored to be under the shared group.
> > 
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > ---
> > v2:
> > Move to shared testcase instead of generic.
> 
> What's the purpose of shared/ ? We have tests that make sense for a
> subset of supported filesystems in generic/, with proper _required and
> other the checks it works fine.
> 
> I see that v1 did the move to generic/ but then the 'shared' got
> suggested, which is IMHO the wrong direction. I remember some distant
> past discussions about shared/ and what to put there. Right now there
> are 3 remaining tests which I think is a good opportunity to make it 0.

I didn't suggest to make it a shared case directly, I asked if there's a
_require_xxxx helper to make this case notrun on "not proper" fs, not
just use "btrfs ext4" to be whitelist :

https://lore.kernel.org/fstests/20240312044629.hpaqdkl24nxaa3dv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

In my personal opinion, the "shared" directory is a place to store the cases
which are nearly to be generic, but not ready. It's a place to remind us
there're still some cases use something likes "supported btrfs ext4" as the
hard condition of _notrun, rather than a flexible _require_xxx helper. These
cases in shared better to be moved to generic, if we can improve it in one day.

It more likes a "TODO" list of generic. If we just write it in generic/
directory, I'm afraid we'll leave it in hundreds of generic cases then forget it.

What do you think?

Thanks,
Zorro

> 

