Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D574208A7
	for <fstests@vger.kernel.org>; Wed, 12 Feb 2025 04:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739335653; cv=none; b=UVy9uCNQ29QY1/5QRyp1puhM3qfcpMFqb0vSqydf9wkSjo+zgPbfnh2H0vgiXI9Aylq5mmPUKhqJpBtKYHUZR5YmA59ZXrstmhuF4okGnkYr0n36vqDWx5auci4dU4AG8YVGs682T/dX/nO7Tmq14RgXr+wuTc2hvx5+Ii4GSXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739335653; c=relaxed/simple;
	bh=f27bNBT3p4HquuRq2LPQoRqtTkYqJ2yA6uH4der0q5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVTlKsKmD76bMOIjx0YyFK/GW7rdIMZhexKclSbN15sL1JBqJpMsuwAxNJdZEmEvZacOCjV2rD6TADUGeCY9OB/rzAmTwEKDknqeuiIIbTQ7v+nzQ9RQkkiiKKqaqR1wPgsTW5UfCsTFdp0v2e8ikUjU2NNlSIASIXvi2F9PM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=sXTJVDUk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="sXTJVDUk"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fbf5c2f72dso711685a91.1
        for <fstests@vger.kernel.org>; Tue, 11 Feb 2025 20:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739335649; x=1739940449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EkxBEfne5UM5tFA8NdjfKwYwgW332jJWCEY5tHZ0YcM=;
        b=sXTJVDUkyybWk7Nyq28YgLFqlnFAzfGJxjF4Aew+gaITS21QvICaEs6xTfyicAgc6l
         rF78Une64ypAVK+5bc0fwhJ2dhG3k1tWM/Z/HrT11+qDn9ZowvnmSEBnlMFpEg+a3egW
         60y70ucGyw8RubF3Yf6/nskutQTcZOJoJi138SSKRWaBlyztQrUorqAbdIITEU5VJ1Qv
         NuagulgmXhLX8FCv55/jvJoNweP+KMDN6WtrVqubed/pUFc60+CFVqRpnmWVKQAEfAZN
         2PQ0udtrtYxocqUroX2EsL8Gz+8uhvk3AfWy/lHyomgBaq4ODx8GwJ9bEYowQb866kAW
         mb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739335649; x=1739940449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkxBEfne5UM5tFA8NdjfKwYwgW332jJWCEY5tHZ0YcM=;
        b=i6v9svcoTi0zWvjrIlLu8SSKCmTXFAb5pndI01mbGKKlCKwbEEoPX70EI4dc36D6kK
         16O8EH0w22agg4cINo/vMTGLUC7A3lEUTv/BraUu+UVinJSkt8CrcA65CtJ5YTMrFvDQ
         n3Rk2B1diUKXkpSZkm3Xe7KNGg+0m3eTrqUu5me4X5x8rM+EwuL6lsWpNGUXIaCicR1Z
         aEEPiTVh1aKfti99nnsMTMJPnDZZvyZKioAerEDJjrZ3XfJVGq1SmF/J1nHPsyIlhB3q
         n56D+4VWSAASK3KlL6yPSCoFQ7wgADKQIfKqhSxRLzMP4YSulKjEOI2rA78QjwCiV2Gb
         NXLA==
X-Forwarded-Encrypted: i=1; AJvYcCXGwiR47tJfcWoEgbgKia4hecA+4P2D+epqeuaWx9baY7V5OV0yzZnLLeFdNCgoJOVFo6XTQCBx@vger.kernel.org
X-Gm-Message-State: AOJu0YwJacBxq8nmz+0EDkPSBIzvAy8KhIpM+G3XbzvDGsnjKhiMsZ5T
	9YOTJEi4bgRfmxyGl44c0BoXOnA4SaMk0oOEMc0vZHxCLwJcoqxgBRDr63BVwO4=
X-Gm-Gg: ASbGnctRjZJR7n5NEIeNxAusuPURzylc6/jihmaG+gw/EnxYt5phMRSoznOz3Uy8Y6p
	fKv5+tTx4mq+rey91CDG9vRMx7zO1ungTiEuK2Fd26N4ALnFrd8JKVMQ+o2ryo+S7caBU/utN5g
	C7g+XR72OK05K5FKGNRtf9rQTVqUiGlIJ8VVXKH/cI/yZXJCaY2H+6MazoaGdRB8iaz/WTcWqKp
	A/0YlKtDz+/S7ZbYpA4oN29RQc6e57zBwf1G/r4I+Dkh9HsLCK36Vxb9/1gbAhmyKd1f3OGFZEz
	GQrxv/VlJR92aHiFhPKFOCq/Vyk/Svuv4+Zw35qfvkl7YRl0xD6uL5qk
X-Google-Smtp-Source: AGHT+IGrlsIFPKBFanuiHBKlDgViUYZSu/xKvZk3p10Pq/sHkgP6fZDQnJuANfuU8HomnGcQPTYegQ==
X-Received: by 2002:a17:90b:56c3:b0:2ee:96a5:721c with SMTP id 98e67ed59e1d1-2fbf5c2cb7fmr2642786a91.21.1739335649436;
        Tue, 11 Feb 2025 20:47:29 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f698dsm442497a91.28.2025.02.11.20.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 20:47:28 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1ti4ek-000000009Se-1PAH;
	Wed, 12 Feb 2025 15:47:26 +1100
Date: Wed, 12 Feb 2025 15:47:26 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 27/34] fuzzy: port fsx and fsstress loop to use --duration
Message-ID: <Z6wn3g9TnZBZXnfY@dread.disaster.area>
References: <173933094308.1758477.194807226568567866.stgit@frogsfrogsfrogs>
 <173933094766.1758477.9477390850462245159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173933094766.1758477.9477390850462245159.stgit@frogsfrogsfrogs>

On Tue, Feb 11, 2025 at 07:37:43PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Quite a while ago, I added --duration= arguments to fsx and fsstress,
> and apparently I forgot to update the scrub stress loops to use them.
> Replace the usage of timeout(1) for the remount_period versions of the
> loop to clean up that code; and convert the non-remount loop so that
> they don't run over time.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/fuzzy |   49 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 20 deletions(-)

Looks fine

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
