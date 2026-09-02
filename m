Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101B84A2E3F
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359999; cv=none; b=JjOtAOhltb/kcpo9ZkCQkjQGIGAlQ6nPcFxP5if2hfQW/Yb0L5wwxBqAf+wmIFFDIpIxMksu2HgZ+LyH88WQPoaHmZnA05WCCQ5NBO4yB93EdwPsvYrSA3wrNgECLMUqjS3isH2pC872mvCxXO+3/edEWsuFtFXzxGfiWDZG7Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359999; c=relaxed/simple;
	bh=Mqpt6kvzGUNOcGC9zeM0PAxbIOJ7PoiMDLNYqJ7yo68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzKN7I5ptGfGBlAHAtjt4BGYNap6WJ3Nep+Ir0Y1qBf809iAbfI37d711pYjCc8uUxhRdITptiVtJ2o/2+9PN1cDaaComrS4zdCPhAl2QDX/jFvasMWGOZFjTjdGkV9t2278dPTom42q1nOjU0vY9su55Nglw2/lzTqb89KPZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdpo2EJK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdpo2EJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB8E1F000E9;
	Wed,  2 Sep 2026 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788359997;
	bh=Fr6k1WwqCxgN6aNYD5M2ttgQibMrSvNJsDUer6bgKX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kdpo2EJKpFczo+s56OGGup4zNuRu1hpQf36OqjJAXlLgP4qbslBYEPH8G8hpwgDq0
	 +5TpTLHJITHZMYtUHfzZpJpzJSv4AbSV/jP3SMmjP/Kixv3FlQU7+KQjvfIL9D/6x3
	 LSuukkdUtOgUR1OmyGEmk/q1VsMKB+IoP9sIymeuwNsYqVJC1qba7EYSXvn9BmYx4o
	 nfUo7iin5d/ZVnMWnxcKEQzLFJUpH6j/aX4ieaPIUtotZ/Lj5HFNJXG6jZ2HQVu9WW
	 Uu3il/FWbcbT7xZPQkBs3Is52liB6vPnqOi7TXj9Ic/71cOWhOY/842ZeCuqk4yRYO
	 Br4L8fKgiUpSw==
Date: Wed, 2 Sep 2026 22:39:51 +0800
From: Zorro Lang <zlang@kernel.org>
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs/024: add missing execute permission
Message-ID: <apg0duan2deLzcvv@zlang-mailbox>
Mail-Followup-To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, 
	fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20260831104142.2229-1-prabhakar.pujeri@dell.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831104142.2229-1-prabhakar.pujeri@dell.com>

On Mon, Aug 31, 2026 at 10:41:42AM +0000, Prabhakar Pujeri wrote:
> The test script was committed with mode 100644 while all other test
> scripts are 100755, so check fails to execute it directly with
> "Permission denied".  Fix the file mode.
> 
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
> ---

Fair enough, in hindsight I should have bundled this change when updating
f2fs/024 last time. Anyway, this fix looks fine to me as well.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/f2fs/024 | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 tests/f2fs/024
> 
> diff --git a/tests/f2fs/024 b/tests/f2fs/024
> old mode 100644
> new mode 100755
> -- 
> 2.55.0
> 
