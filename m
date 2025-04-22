Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A55727BF7F
	for <fstests@vger.kernel.org>; Tue, 22 Apr 2025 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337406; cv=none; b=rTYfeQMaVgDJl3llJ4cQgde6VRDZR4TEjsXUIW44R0D/gO3d2Kq2zuK7MuJLXRETjus6Ca+COpP/nAw3GJ57iQ38FDRqWYoKW86fT8S9Bn/OBL/eGe6OIGD6m1mw7zcPNxNPNLHbxbhEJ4HmhhiQCu64Nf8O7FumHnkV0pf7OX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337406; c=relaxed/simple;
	bh=YzbW6YmwLGxAGAwTfuFxnztEoc9iq66tR3gHscveKYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXPSWxrktgfudzELTJnN8/K+ODMldnatqrO4hRZ0SQQQyDaTCXn1iJvVwl9gJVACT+bRXmkVOttg9bW62ex+94ZIoIXtrSKyMu5NU/zi7ZNGR3xr27LPU/cWZ9vr5I0uO8CeehebRhkuPdLeiI2betmqeAruNDbV/tBaUy31EDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=iAoGAWE8; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="iAoGAWE8"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e643f235a34so4057277276.1
        for <fstests@vger.kernel.org>; Tue, 22 Apr 2025 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1745337404; x=1745942204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud0elHOnGc7hP9hnXKYDw9mCfGJKR0aC5uZ6ImIK2S0=;
        b=iAoGAWE8lNloIU9hl8Ncnm/5fR5NLd/6uELd/MWp6ydgE+Ct/6oGEM5UnbzSpD3e0z
         baLMCR50P3IfS7Img3OuiqQhH/5vicmDL0hg0gCGUtrQvqiJutnyewxLg/iNudGdSTPR
         AUDeKLHVYrVTH0ad2a7zPN9SG96KABTXDlunIdujm8BlE6snvqWnz7vb/dfGhh4aCyrm
         2tVdX+MEaozGW9s2JwdQB/GtzHtZSNVaMMZ5GJLr8gQPjHoref88d0z4HxsVXVZhe7Dl
         u8eZh4ZbWyy4S809acLdAceFUy+hsU9wd12/ZLDlF2Oey6zndl3GRHQ/CFC4henlXHWz
         qzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337404; x=1745942204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ud0elHOnGc7hP9hnXKYDw9mCfGJKR0aC5uZ6ImIK2S0=;
        b=FUb0ybLp7TX248ALEbW9JfTg5yaS2zzKpQUpBx6EHiIXv3SVv0P6+19IWNzybl4wnQ
         Stq1N/nyF17EYxe1HoSvYeqJKOd5NG3I8FjAxsi6g0DRd3bpAggFnCR57TmyQgxjLexc
         DLg/FOilFvZsJDTZ7Z1O6Gs/MgidKON3/KgTR8yhO9cPh849kOGlX8aJ6o6WfAxmhTna
         mZIzG+JBK9kLlLFNS1+csiXpMYIfKbRChnpyYIHUQDUOmPSUgo/kzDUm+rIOnOmV7vgW
         JXJm5JE1LkuF2EmLEJIrc2VtiKskJDHocrguvNc+OKEfhJlt5yJI119ITC6aM7BSunJf
         //CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhVx4IFI/8db4tZuCCswTKjH3KOjEoOHuIO1/NBlu1IhN+/kpbC4nnMWAavy5t/5ikTY95yy/X@vger.kernel.org
X-Gm-Message-State: AOJu0YzHe5tUv5QD5QEdF9/1vmrxwY8ogbyYxV8b1cu+OK20S63GhegV
	/OctloO2B+pskN4UMJEQH6KWnxhg+c4RM2Me0AtRzE6vR3FGdAlUqtPRMjiGd9o=
X-Gm-Gg: ASbGncuQD5Yq4DqbS8Ns1GN9fYFnjpWqOPesdf7u+9nOoySYxdlS/a1dhYkvgQBbZMV
	EZgWWq2bTEiPGX0dfI9WLiQILXefIqCatr1gTARpO43P76NYPUS6iJHcnR2LSJtvDzp8yCxUZKi
	8pWfznm6ozeEoQX+gju4sZt+5DLLA2YkI7BFtfpvQvXnHvhUkJ79W8GFa0Tj3WGQ0rZCqoaNvUI
	QiAgWHPmL8tfplg5MfEkMyCl/mVRzCtwWAEgdrtNRdskiWiNc9OA+/0J/Bw9WSKVcg9nlJjnUbe
	kl1e4/mVDsE7DJvm62x2lmhrI9wfd7az3SScS24Q4BT/Etn+DuC4W41FDai3m7v5aCjYUpThIFM
	b4w==
X-Google-Smtp-Source: AGHT+IEVuPY/rK8JO2Vk49NdcNgfrjqZx5Fv7Hn4PhE64NkJ4mffngGAbhnWdxGX8THzU67W/mWEGw==
X-Received: by 2002:a05:6902:4484:b0:e72:b231:7b6d with SMTP id 3f1490d57ef6-e72b2317c4dmr12766694276.34.1745337403998;
        Tue, 22 Apr 2025 08:56:43 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e72959e0fd5sm2440290276.55.2025.04.22.08.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 08:56:43 -0700 (PDT)
Date: Tue, 22 Apr 2025 11:56:42 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: common/btrfs: add _ prefix to temp fsid helper
 functions
Message-ID: <20250422153220.GA258462@perftesting>
References: <6097a2fd8b587ccc5982106142421f472861e949.1744892813.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6097a2fd8b587ccc5982106142421f472861e949.1744892813.git.anand.jain@oracle.com>

On Thu, Apr 17, 2025 at 08:27:22PM +0800, Anand Jain wrote:
> Just adding a _ prefix to the two temp fsid helper functions and
> a rename in common/btrfs to keep the coding style consistent.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
