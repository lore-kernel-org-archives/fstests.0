Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9B1A83F4
	for <fstests@vger.kernel.org>; Mon, 17 Feb 2025 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739831351; cv=none; b=Q/USHQ7Wea7f9KYLUi665wCiKog1fyWhGPonQIgdMSx7BvG97R5o3vRxhae7DnK0Fk9B+ZQH3ipYQ4N3+VIWPCrvfrLUvbNlZYESnbgz1AbzsQV+7ipUkzYDr/Pb7i7ax70BJuHkTzHAH2KjAAU5bgrFSZx8Y9dGKoaVSwIgjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739831351; c=relaxed/simple;
	bh=tiGSLMs0cfOD2R6DyTEDZg7JHzKY793vDrUifSZhHG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzCprPD8jGVWkHTyWUly/HQE/b8O7AL4HxXM8edsMRamVdjvcS0dz7x9DAWdkZoD9zDG43vhdcFZuk7tWaIA9cQgNqCBa1CP9D7HBrUSyX1bzGPm5zyrZ5XN5cYHdQHi5pbbtCBY2NpmMRHjFzKTYkXNSWszYgdt9zKxrtlruIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XS3e5zhk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XS3e5zhk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220d39a5627so69421095ad.1
        for <fstests@vger.kernel.org>; Mon, 17 Feb 2025 14:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739831349; x=1740436149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0dCyPtn/RNwGDNdmqIJozgGvpDBIZ/1Rg9UhGXNP2w=;
        b=XS3e5zhkyRLCgb2HIqHoLytXT09qPsszYdpqbUnv06jEvVHRiemknN1GNG9ARHCCi1
         nizaheMcqhzI6oFga0oqadEKWXQ+pKi4Kgwvxbt693n/JdhBfvWLLWExZ2OCYhIAPrxM
         ds4FynubLxmXvA7TtDSmRVcEFclZq+dV3mwdnjR45OJAL9OBUqFPhat3XXJy5DCm5yAq
         mwiSoIBZTxCixHOw7wSA17PdW4UNT8lY9WwuatjBbBbeL8OiwhkjfLuEAmKJUNlTJShN
         pkDi+P1t0afqis7Ix1b6GD7PIkybzMlAU4bcQhTVD+MW/8/nsYlik86xWtq6Y2MujGKk
         0wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739831349; x=1740436149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0dCyPtn/RNwGDNdmqIJozgGvpDBIZ/1Rg9UhGXNP2w=;
        b=AZqpSKwqnRKkIHs+rqhBUiNKAVlD2rkSlOGUdReSw1J6ce9ZWdgM53Isg5UzB3vulj
         yQG8UMrc2J1VQ0iuuBEWpU1GhinCucR3PZRM4IptFPBx5/lECJCFA0S8IZ7ovPlXzKp/
         9hxDRMMwlujBhahEurCEG6hXlqOACoGqJRXnduMXSBeJmQpWGo3/mu4HVF6OkmMoUFSp
         +RBK4OIUO0X2EPsH0crOSenk0Dz/SQ4cQP6MAUkOSvRuXf5CFYUh2wxgQlieYdraQBbU
         0FYroCc3nU0vqtFUVhC25NeunASjrNE5Ym1fF3V5BPfksLPe6RmglUJZH0gaBc9Fy4PO
         ETig==
X-Gm-Message-State: AOJu0YyzU50FAsJaFDUVKvC1I/2mOsTazFQQUuZyUkP+rHLvEJJ2uIIs
	sCkvk1hGFfDdEmcAtfU1sTWUmITzFJZgUkdTIb64pVit/Ez7hLeZZ3lVvyqCQOpBNTKpfTatFHh
	g
X-Gm-Gg: ASbGncssCV6CyKD8CWV27oU6rnI97Gh1OJrmbLh10BN8BRFa2nGzK2/ADe92VBQPZjk
	zK95W8BjYQgrOos+7NdKaneKlwT6AqGmsiam50V7cOw4GOMpsY8G/qgE7jrigv2J3dQax7sk5PX
	J3+5wKC6K+SCfYj2qWdi3SF92giMwOiQjyy9Zk+QKT76T7DnUlYUaxvd/BL9uWcxslcO8VIcWuk
	oiuR+HQhVFM68Cj/iNe9XNAouqfqP+hniqddDKAJe2UTrJVXsO5A3PiadHBGD7CxUoAYkCP2fe9
	vnhRJWjBJcS5Q/9sA1NAqMNv246y/tui/8U4UexaqRYLZhI4ommoyXOyL9dQau6eyW0=
X-Google-Smtp-Source: AGHT+IGP5rIz54g30tIU+OVmpyVDidpTBJehmNmoUnC6Bu3VUGAv2em/Nl0f9iSxQUbPOCb/udVMZg==
X-Received: by 2002:a17:902:e5d0:b0:220:d1c3:2511 with SMTP id d9443c01a7336-22104056848mr160751525ad.26.1739831349292;
        Mon, 17 Feb 2025 14:29:09 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d537d0f2sm76777785ad.105.2025.02.17.14.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 14:29:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tk9bt-00000002Z2G-45mU;
	Tue, 18 Feb 2025 09:29:05 +1100
Date: Tue, 18 Feb 2025 09:29:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v1 3/3] xfs: Add a testcase to check remount with noattr2
 on a v5 xfs
Message-ID: <Z7O4MZ0xOpO_GTKE@dread.disaster.area>
References: <cover.1739363803.git.nirjhar.roy.lists@gmail.com>
 <de61a54dcf5f7240d971150cb51faf0038d3d835.1739363803.git.nirjhar.roy.lists@gmail.com>
 <Z60W2U8raqzRKYdy@dread.disaster.area>
 <b43e4cd9-d8aa-4cc0-a5ff-35f2e0553682@gmail.com>
 <Z65o6nWxT00MaUrW@dread.disaster.area>
 <1b8a4074-ae78-4ba2-9d8a-9e5e85437df5@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b8a4074-ae78-4ba2-9d8a-9e5e85437df5@gmail.com>

On Mon, Feb 17, 2025 at 10:18:48AM +0530, Nirjhar Roy (IBM) wrote:
> On 2/14/25 03:19, Dave Chinner wrote:
> > On Thu, Feb 13, 2025 at 03:30:50PM +0530, Nirjhar Roy (IBM) wrote:
> > > On 2/13/25 03:17, Dave Chinner wrote:
> > > > On Wed, Feb 12, 2025 at 12:39:58PM +0000, Nirjhar Roy (IBM) wrote:
> > Ok, so CONFIG_XFS_SUPPORT_V4=n is the correct behaviour (known mount
> > option, invalid configuration being asked for), and it is the
> > CONFIG_XFS_SUPPORT_V4=y behaviour that is broken.
> 
> Okay, so do you find this testcase (patch 3/3 xfs: Add a testcase to check
> remount with noattr2 on a v5 xfs) useful,

Not at this point in time, because xfs/189 is supposed to exercise
attr2/noattr2 mount/remount behaviour and take into account all the
weirdness of the historic mount behaviour.

Obviously, it is not detecting that this noattr2 remount behaviour
was broken, so that test needs fixing/additions.  Indeed, it's
probably important to understand why xfs/189 isn't detecting this
failure before going any further, right?

IMO, it is better to fix existing tests that exercise the behaviour
in question than it is to add a new test that covers just what the
old test missed.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
