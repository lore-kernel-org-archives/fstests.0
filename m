Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD78625D209
	for <fstests@vger.kernel.org>; Tue, 11 Nov 2025 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826028; cv=none; b=HGIfpFTwnh65FC2644tKH76cE3JxRKTzz7gpLTuw7UK7oH3FgqYh+RUqwj4fw0p/OpysJdUo3HvqDWinD4vaLHd0nBv+hL3fE4oMVuvYKlFKSRpJaAZKAYUM+QH0E+/px1CWnuuWZX0+Zkgw+GqMjNE+omZT0LZBqWRlKauZa9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826028; c=relaxed/simple;
	bh=SPfbF1enqcwOJRfEotXqWEZmbDB6l5+fT/yGsufoUc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfSg4InTr0fRbaDjC0+WImWOk1D07iVQpPt9MnSnnx7eqWORw8ZHq182ILrfdGhsWqSynXcx61F7xckudi8oW+tgyCmq49prb24OuLbNmw0BtX27w/bK7Du5YaKtbiCVGwIeE/ku99y7FHMQinC5fStVmUc68ekCN5lGfI8JU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYlk+tgn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fL9Fbzvb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYlk+tgn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL9Fbzvb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762826025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3XklV9O6JekcN95bHXyedJHLFaMcI+Z8eQK/xCQbnU=;
	b=FYlk+tgnKDJKHnj1OV1tCaHlh3m6nVajp7/SBHiSVgBsoSJgUm6TUM8Z9f0Tlng6ESQO3T
	YT/tXrayFPkANluYuakyBuKxXXEPO+RK+SI4ZuqoipkCT0S6g3gzDeTV8jucboAkVkch+e
	RvUEAgohzYeCCYAWhxrp0i7dx15m+mk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-tw6UKcVmPHe50OejcXnntA-1; Mon, 10 Nov 2025 20:53:44 -0500
X-MC-Unique: tw6UKcVmPHe50OejcXnntA-1
X-Mimecast-MFC-AGG-ID: tw6UKcVmPHe50OejcXnntA_1762826023
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29806c42760so48619535ad.2
        for <fstests@vger.kernel.org>; Mon, 10 Nov 2025 17:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762826023; x=1763430823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3XklV9O6JekcN95bHXyedJHLFaMcI+Z8eQK/xCQbnU=;
        b=fL9FbzvbaqQlZgdGTSUL6DDDXPNyHSYyL8Xs4JHrR7OupVSeqNkEbfL1UOkgSelAF2
         PXkAzl8jp9Qj1f9jtt+6jOrw9ZProDxE2QEpq5GbIXY/UWjGUtyI8AUzw/TDHOXBjGeT
         NMCFB66tDZ3k1xwtjXCj4nI072ZF03krBY2HBKydRAqteKQlYIxImAhZcbJNtbTZYbT/
         x11xvSeyyZpQBWZXV/M3bNOZXQ7il9p3bFunbPpdGs2QfTWQ5By7/hI6j0JuoR6T7Bg2
         Y+N0WtnAhK2wttJ31oXi2UM2eFcStUkXfSzDMsLGvGCq1uk8msFFvFLvo9wZTKI4Taf4
         yEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762826023; x=1763430823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3XklV9O6JekcN95bHXyedJHLFaMcI+Z8eQK/xCQbnU=;
        b=hWP5uVYpKPB1/WikGX7kKV1bZdeYlG6FV431SOxTONN9fu8P235IbleSg6cihckJ9i
         cPEYIEegLE96GcLHSnqpUhE1taWiByU5V1GneAke5MJDUlQ8ILhKyMa/THIyBpqPhITr
         DmPu6ULUMdyrWlNTrDBXEzVJkCYrvL8duPeqQoQZ/UAoynA+4qy8eYr06myucvGhmjrz
         Qi1l3fQf9+goAUm1Dk7aofQwhc7lHbrSef4z0OXe3KCmFUae7sM7+Ve91Z2cRM1G8Lmc
         nd4tNHLhsBYEd/caBP+NAZ9C+hFnKxQw7WDHOKV1FWwEeat6JJoqKW/nbrpg5B+Igda+
         VSUg==
X-Forwarded-Encrypted: i=1; AJvYcCWO+DAoTbx1shMS3LWKnJOv2p/pXclRXpva8LQxAuYf45u4GufLhUDbygQ5yQEU0Mwquf4z8M+X@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ2WWNrKHFo2+uyTd9RN4qcGpRoexkr4jeLXlQLbTXy45aJGjT
	uOJZSTQgpRF4vYo6hsLNFn6fq4lXjJ0kpm9rwN3NFiDH2HklIat/BlYDpf/2ZDn5XutnYBMxlpH
	qkCI/ojNvYX8VXRpLnfZ0+PSpJngFJJ40ZvnZhC1PyEWaXXVO6PBpSJ4J+/Y=
X-Gm-Gg: ASbGnctVPhPuLlT8Fg1KfdRaHZHe+e7Hxhg1Z55Lq2CArgncZgxz3w+R54pG+tW28mz
	hbfJcOzAkccodMlHUJSRoIt9lb0NgGDDoCMkWq/Jr5H6Ym9GS9AH94Oa246LT03kt0r0mW1k+oX
	5GkU6+RcVJW7MRCfGrP1+N1wplWuje4czfQHSb5WlrgbchAsPZblOt6ZLAHoiC4LBgh7SE1G0b5
	7wt4Hr5B88M00gqtSP/WssFkCbomdW0il7Uwl5UPjbajXUfg1qppjOWQUoigwEvm0BAPyfZ7oog
	feuQpCqF6CykNhDYcX4HMhneiuvBTshkHkq8xi2slApZ6dh+up6Bhxsj2oWvdm31cvg8wZbgTao
	IzXpe1QT2vNIDQ+/pp3Nm4USgC9ptffupSokQwSA=
X-Received: by 2002:a17:902:f605:b0:298:68e:4043 with SMTP id d9443c01a7336-298068e42e5mr92058425ad.14.1762826023005;
        Mon, 10 Nov 2025 17:53:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGw9L6g4D6sX0IvAjppdudhuXGvA+ISsah2FfrH2akNkOHl0K3UoiaaaRBuHYOdHlzQV1taQ==
X-Received: by 2002:a17:902:f605:b0:298:68e:4043 with SMTP id d9443c01a7336-298068e42e5mr92058065ad.14.1762826022554;
        Mon, 10 Nov 2025 17:53:42 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b8f4sm160191885ad.10.2025.11.10.17.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 17:53:41 -0800 (PST)
Date: Tue, 11 Nov 2025 09:53:36 +0800
From: Zorro Lang <zlang@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "tytso@mit.edu" <tytso@mit.edu>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"wqu@suse.com" <wqu@suse.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] Why generic/073 is generic but not btrfs specific?
Message-ID: <20251111015336.dz6um6vqpp3qxn3h@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <92ac4eb8cdc47ddc99edeb145e67882259d3aa0e.camel@ibm.com>
 <fb616f30-5a56-4436-8dc7-0d8fe2b4d772@suse.com>
 <06b369cd4fdf2dfb1cfe0b43640dbe6b05be368a.camel@ibm.com>
 <a43fd07d-88e6-473d-a0be-3ba3203785e6@suse.com>
 <ee43d81115d91ceb359f697162f21ce50cee29ff.camel@ibm.com>
 <20251108140116.GB2988753@mit.edu>
 <afcf903f52393132c98a79726d9b5f51696e736d.camel@ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afcf903f52393132c98a79726d9b5f51696e736d.camel@ibm.com>

On Mon, Nov 10, 2025 at 07:41:40PM +0000, Viacheslav Dubeyko wrote:
> On Sat, 2025-11-08 at 09:01 -0500, Theodore Ts'o wrote:
> > On Thu, Nov 06, 2025 at 10:29:46PM +0000, Viacheslav Dubeyko wrote:
> > > > > Technically speaking, HFS+ is journaling file system in Apple implementation.
> > > > > But we don't have this functionality implemented and fully supported on Linux
> > > > > kernel side. Potentially, it can be done but currently we haven't such
> > > > > functionality yet. So, HFS/HFS+ doesn't use journaling on Linux kernel side  and
> > > > > no journal replay could happen. :)
> > 
> > If the implementation of HJFJS+ in Linux doesn't support metadata
> > consistency after a crash, I'd suggest adding HFS+ to
> > _has_metadat_journalling().  This will suppress a number of test
> > failures so you can focus on other issues which arguably is probably
> > higher priority for you to fix.
> > 
> > After you get HFS+ to run clean with the journalling tesets skipped,
> > then you can focus on adding that guarantee at that point, perhaps?
> > 
> > 
> 
> Yes, it makes sense. It's really good strategy. But I've decided to spend couple
> of days on the fix of this issue. If I am not lucky to find the quick fix, then
> I'll follow this strategy. :)

Hi Slava,

fstests doesn't have an offical HFS+ supporting report (refer to README), so if you
find some helpers/cases can't work on hfs/hfsplus well, please feel free to modify
them to support hfs/hfsplus, then add hfs/hfsplus to the supporting list (in README)
after we make sure it works :)

Thanks,
Zorro

> 
> Thanks,
> Slava.

