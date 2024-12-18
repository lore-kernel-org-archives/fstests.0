Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D2C17A586
	for <fstests@vger.kernel.org>; Wed, 18 Dec 2024 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560774; cv=none; b=reZ3elKQWPkJMUVO1zgwYAkxmZ7x1IA/89G786dECLARJEXBz4rPuK5c6zblstqEC/lBXoWNagV5zmc7w0DmW0p8LZmjquVfvZdYJHxiFBHeoV0ZyfcWdY7+LSm5x7IYHnDIGmzoH83yDqVtyncv77nGjA2xBUjGvLQmhNLbkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560774; c=relaxed/simple;
	bh=8vwhHmQLEpkZmpzcrcDMP0ub+kyd8l6nrOijMTDS6Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxN9HTfHeIScO6GOe3vOwQsl52mB4fdveVtNwh4F3YeL2jzMQtv3Qt7dopvJbuLUJvIg16zoYePmPC8K6cH1rQJaUTX0i3Un4UN30sqwt+ozB7TRHp6YibIHRvszMKlTWmlZojHKkeq+M1q6oJVd9dMFr+i5nTx5evy8WOJ8a/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=HjleHKxJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="HjleHKxJ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2164b662090so1449345ad.1
        for <fstests@vger.kernel.org>; Wed, 18 Dec 2024 14:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1734560770; x=1735165570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vOeB6zA5skaMzp4ZAiz3xHlYIdAmnlauE5YvU+UAmpc=;
        b=HjleHKxJVyJ1O/1eXCED5sfIKEQsp5hjPKTHX0lVzRDbeQP5+upUjmfB90vA+F25Z4
         HJqZUs9wFIF+oViEf6YDFEPmGu6Kfd79kd1LsD8q7hEJV6W9mCQNIPLaqInGGtYUVudD
         Wes2kzBXHQhA76psXMFG/NrmzMwrCWZEYjMqRfaGIuTIoz++rJYwSHoFJxKzlh3+mp9E
         MsxnN2BS3GwRgvatX2S5ljDuInzYxvA2Lku8Hs1nmKj23uYP04iiuAUCTSc98RjNW2W/
         UjWrXQC99jf3RVn6WYJ8XcxyUk5Dzi+4wHHjH0AmtkdZM4Cih5esmaHXhicyA0IxQ2Li
         KXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734560770; x=1735165570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOeB6zA5skaMzp4ZAiz3xHlYIdAmnlauE5YvU+UAmpc=;
        b=wZ9U08BR0Diolo2tyq43doVRb4PLKsFvmsW2UYyQmj0JIGT9uB+38deQMm8fkqhnBz
         EVKkENf6786CFM7tYF9C4wODN4ZRkd5iVSrr0mV8AVr7xIPaRtvgjLCWpjFqWw5NXKQ3
         ttYnbl4nAqdaM6k/Z0r5nwX0NFzDKRvMEZIL6cAfkp1AaC5ElE6I0nxeocN2UyjLnKR7
         rh7VoGneL/KZLeI1bQj/1wp2kUektHi5y6ew+nvazk26L5iQ00Q877JYOJOSco2SB5tf
         NpcsBJtnQprbppFTsm70lODCTsariOO9ukUE+Ejduy0Gn8sLaHRLPFNTSdZl8/+imWuD
         Y3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXmeThhK1kYYMobzPtaVnVxvIHHfG2j2mSvgdSfgy8jqOPivhKLltoqjr2CGgkVv9o+EOOxATLl@vger.kernel.org
X-Gm-Message-State: AOJu0YxQMOTg2SrXx3XwGOsmq70HgH3VxCHe+4NbKAwZBe2d2TmpZpqB
	EtIzIXCpp7VSVHHlDz2iwAiSBFw2PHa3g+NKeuo1JUASvirl9RSwUvZUsJQ0YKlyOrYVLlZ74PT
	b
X-Gm-Gg: ASbGncuTp6VCNvNGxsZqUQfyoJ1co65js3sRCYZ02rwc0b6FRkUklOrzjwZ7i4EFQD6
	wOf5/sI5Y2pFcBa8Y59hWLeUqlD4woEvYgpYepr3wwxNHz7AtP6mSuB1j1mqETEt/dpqwxmj6lU
	VCgYrvA3J6GiTD91w6VrnouSDLY8auRWFds5OU5tf3VSFg6DGVTP9HtePyi9UDXOhu0RCFCY7Dq
	w1s2KnGObW3mrwgiyZUw3yPRYTj07BdAVOAGpQYZHxYztiWSnQEQzBbe4f2g7a+w7fOO4aP/1Z8
	8TcpXG1WpJn43l7GXuORUkit+cS9Ew==
X-Google-Smtp-Source: AGHT+IHKshBMFKmtZzz13kC8NcY7XsU1uwfx/6DQrlyP2WPK4iC6sHjMnT72lTIGzitP+crFYSoOJw==
X-Received: by 2002:a17:902:cccd:b0:215:6cb2:7877 with SMTP id d9443c01a7336-218d6fcc257mr67215565ad.4.1734560770430;
        Wed, 18 Dec 2024 14:26:10 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca025d1sm255805ad.254.2024.12.18.14.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 14:26:10 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tO2UY-0000000CQl8-47bI;
	Thu, 19 Dec 2024 09:26:06 +1100
Date: Thu, 19 Dec 2024 09:26:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/530: only use xfs-specific mkfs options when
 testing on xfs
Message-ID: <Z2NL_oc5QSscZdZ_@dread.disaster.area>
References: <20241215051242.3340572-1-tytso@mit.edu>
 <20241215051242.3340572-3-tytso@mit.edu>
 <Z2EyG0vqtyTSyM5a@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2EyG0vqtyTSyM5a@infradead.org>

On Tue, Dec 17, 2024 at 12:11:07AM -0800, Christoph Hellwig wrote:
> On Sun, Dec 15, 2024 at 12:12:42AM -0500, Theodore Ts'o wrote:
> > +if [ $FSTYP = "xfs" ]; then
> > +    _scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
> > +else
> > +    _scratch_mkfs >> $seqres.full 2>&1
> > +fi
> 
> We really need to document why generic tests have file system specific
> hacks.  And yes, that's a request for Dave who originally added it
> without any explanation and not Ted.

Creating and then unlinking 50000 files is journal space bound
when using default 64MB logs on small test filesystems. Increasing
the journal size to 256MB halved the runtime of this test.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
