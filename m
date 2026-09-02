Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE214A5ECF
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361160; cv=pass; b=bMKZsjNOXoOYmBIJBfRZ+fH75eC629GE3U0CUJI1bl3frMbeWrrqlvdeuy87GbHCsmqWfeymT/SItyOXe7LN1MP+mVEGMBlRFAW1mscZ2kUtrmd5DkDQ0aPgZ70jQjnc7Ndg+gemxE4Sr1dUVQZ0PL5pAZvEQVd0ksgFBv+V5h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361160; c=relaxed/simple;
	bh=HB5a7zWHBi7h7cyNDfYORnxJhgpM4GZcAwpKf23CKyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIztV9wLYLdL/pSEGUPCow+5f0cYPtehS5y8ofwfVmiB7zoRe04A6hBIsc8Et8BmXtNVBO0tbu46PGo4SpuvjQOFukgUhKJCXzSvWqIl1LgxQls1uApaccXMWTVYcsxCJGcy2jNCVcEiHFRlj3hHmkHTiHpSvLHnbErh4mCGLW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDEPnl0e; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDEPnl0e"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a65e66555cso1706256a12.2
        for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 07:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788361151; cv=none;
        d=google.com; s=arc-20260327;
        b=r0WjC+9/+J5C8aPi/MmjPI4SBaGQqUBFV0ooHJ5t0bE9/anGscuSUZZgBS2MMAtG+0
         SrWfibMMjNlc6yCxngpEwWusmIJI/lR9A2dWJBLMuRtMHQjTxIIBwniHRvLCVKgB2rQO
         iuHR8fgI5Bue8VHwa3CUP9qu5nNGnBopa+5F4uTZowxrk0ZXpwmUsDqKIB+7RakLv8b0
         pbutYdT4jP8HwhTrdiEBc97G06TRqeq0AhlOcKriBOSKIoDgvmj+NmKf5uHj5DTyC1P7
         uDmMFLlSgoO0RQLgJLcfsnPIwGXbK3iSGMZzfOVtt7serke9iO0K682qjjrzlofMoYrc
         8zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qUu+63OBJi24hP1aAGOT7rjpn3InrvPoDte6ViOybBM=;
        fh=tozj/5T+3vSOt+mq09lTesx20ZaH//3Tc3RhNI9qJEQ=;
        b=AlG6kY0IlhyDiLOq1wytBKJ2NYb9JMQ+VwI5l35xZgxjfqMI/vhwFCqoKOMCgF1xI8
         yZSIlU+A8yuXYXv1XeNUePLxq4PHyQphm0J4nzHx4rEeOY3J8BgCepb/YCrra1RxjyqS
         BXWiM4lCXM9pw9KGpV7+QqP091otSdviS7Wdm6bs4DjvV97/2CYGBqXCeeD4FkHBXNui
         IrzieCRWNr6OF1knJmu8iBXbRl6/h+DGVedbaJZI1gGfHWjgxerHjtinKQ5nKSqPdiFB
         sLLeZZhNM1824wVfjYzO8HxkkjjcBeIByzoi6cvg4PX/vIA2N7HOvzEQMmcLv201wOHk
         mvOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788361151; x=1788965951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qUu+63OBJi24hP1aAGOT7rjpn3InrvPoDte6ViOybBM=;
        b=PDEPnl0eSocebNs6VrvyMFs/j/aGOcNGWaz6JIXk2G4LZzmRSv17ZnGWvyaiPaH2gO
         2zdqyRzOPFFBbQ1sH7m6pyr3WtHjaPnEVafzq592NjhSlqcPwBF7HWgbeLOm2YewcOt4
         HhPXWhXO0DjO3BcKXKzu6Pd0TZbtGYcD3kcIpNFwc+PjVjG+4wV0jZ4QTUwiycn9R4Na
         c/pmUkXxRI6bBqndwYT7orUk7I8jt2734to2uYC5nrGpOZXHE6fH63vtw4axIHSuEVsq
         Xuoo4BX15dWr1+hVWxiHeqv3xds5NtiutQMZDsRkQFxtYRalbKwSX6FrSIQPLiO41dhJ
         xHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361151; x=1788965951;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qUu+63OBJi24hP1aAGOT7rjpn3InrvPoDte6ViOybBM=;
        b=TjVPbbV0IKa2aBoT69QMydbnVnZer4VqGUemzXrJaUGR37fS8OBBY8rnRs7wEGmGqM
         KJNSDEQdmYKnG/ubHIpnE7lFhAn0KiLqjFrIsxf8QDy9iucP1HVSPfej/CyPr8/UJ9+g
         uBmHpqgHVinw1DM6W5kXLApXqzh1MvZlmm3qWMvy0pO5dt91BcwFIY2SF1VLWzy3KOX+
         1AAAgUyxFBpwVEODhBp0Bog54Tthw+Yylej4PtJoSww/J5jDalVQzXS8KjAo6qGmL+yz
         tpJRArcTOjn2OGvLiPr9MVgOOfNP2lgPRf4cOf3jqvTvCecZMtFlXUwPRjBjp+w8QwSE
         +55A==
X-Gm-Message-State: AFuF++m02YiJvb9L0LYgwWmFBD+94Q8vdRJOtymdL0g6fdXrfbcdNKCm
	J2QYrPpExrpfFbo6QKRJLHiLKfK7rpeuPQicwnda/qP+JoCOVD0V0tAa24TBel3E+Rc/5K8cYe0
	tD8i7//b/MXLFq3tIOqvewN7GE156XTk=
X-Gm-Gg: AYBFou0AF4CMoeX4NNupM9ka87bx1kmaPOwPYJDbUhVVkyE2XJQg/RFzzcxxHKJPW82
	nGfyPCLWy5OrPJEsOuqxS+wc17uuSiZFSjV1lXrz3y9hC+A06YEUG77tXVVtuScoylqfnVNqnGV
	lbtaqBSZqFmLCOptmF4t5sgZMN5hpY87A3su/DQ9PePBSnTiBTUlvDoLJbQXPrT6BIuZrUA4Ut2
	etKG1PaTKb+AIou+BjJJ05Ac/DioIMp0/FezQwy26+5gGXVaLZtPa8XtQbqgkmfEcP1m3o4s26T
	vhE9w6beJiImELaMzoNF6+a72bqOgvWRkvjzjx6Jv0Uqyg==
X-Received: by 2002:a05:6402:1d49:b0:6a6:3e9d:26c2 with SMTP id
 4fb4d7f45d1cf-6a682566f7bmr3532512a12.1.1788361150724; Wed, 02 Sep 2026
 07:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902113536.6573-1-prabhakar.pujeri@dell.com>
In-Reply-To: <20260902113536.6573-1-prabhakar.pujeri@dell.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Sep 2026 16:58:59 +0200
X-Gm-Features: AcwNN1U7EbxJ7gON7cDgh6UVgKvamy007sTuMc5RRVTHDO5MgvgpyvHxsfTwHUg
Message-ID: <CAOQ4uxjaATgsNuz25q273nf5QdzURfC0Ht9t6ace0LVagNbxPw@mail.gmail.com>
Subject: Re: [RFC] overlay tests: generalize _check_overlay_feature for
 param-less mount options
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 1:35=E2=80=AFPM Prabhakar Pujeri
<prabhakar.pujeri@dell.com> wrote:
>
> Hi all,
>
> During the overlay/081 _require_scratch review, Zorro asked whether the
> uuid=3Dnull/auto/on mount options (kernel v6.6+) warrant a _require_*
> helper.  Amir replied that a dedicated helper is not the way; instead he
> suggested teaching _require_scratch_overlay_features /
> _check_overlay_feature about mount options that have no module parameter
> of the same name (uuid, xino, verity, fsync) -- a missing /sys/module/
> overlay/parameters/<name> then means "defaults off" rather than
> "unsupported" -- and pointed out the xino tests (overlay/041, 043, 044,
> 067, 070, 071) practically open-code that pattern already.
>
> Before writing the series, one scoping question: would such a refactor
> be welcome?
>
> Sketch of the series:
>
>   1. Extend _check_overlay_feature() so element names without a matching
>      module parameter fall back to treating the feature as fixed-default
>      (per Amir's note), so callers can require "uuid=3Don" and friends
>      uniformly.
>   2. Convert overlay/041, 043, 044, 067, 070, 071 to the generalized
>      helper, deleting their open-coded variants.
>   3. Optionally, switch overlay/081's ad-hoc uuid=3D probe to the helper
>      as well (currently _notrun on mount failure with EINVAL).

Well if you do the hard part of #1 and #2 better make the trivial change of=
 #3

>
> (A practical caveat: for the param-less options, presence still needs a
> probe either way for kernels predating the feature; the helper
> generalization mainly removes six near-identical code blocks and the
> shared "not supported vs default-off" semantics.)
>

I don't understand the question.

For param-less option the helper will be reduced to
- mount with -ouuid=3Don
- check that mount options include uuid=3Don

What is the problem that you are pointing out?

> The motivation and context are in this thread:
>   https://lore.kernel.org/fstests/CAOQ4uxjBc5CfCpjrq8Ut4xHHaenKicTxBCbNuQ=
kBFuu-Mz9=3DEQ@mail.gmail.com/
>
> Please let me know whether to proceed (or whether you would rather keep
> the open-coded xino blocks).
>

The patch would be welcome.
You may encounter issues I did not think about which will complicate
things - we can decide if that happens how to proceed.

Thanks for following up,
Amir.
