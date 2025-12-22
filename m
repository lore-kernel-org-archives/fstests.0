Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F681C7012
	for <fstests@vger.kernel.org>; Mon, 22 Dec 2025 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766371737; cv=pass; b=ndLfEG3aJkTMJWqTvwte6xdLDCNjiZLIyuj2g/nTT78AX1t+wer+OkZ2e7fQ819WUlEldQet7TiX9zIteFba1gchafkzpsuQZ2+IW3d7udoap5SXeKGdwD+yCfFYZ+ZxVZ38JnapsPRHFUK4290N0CYMFOIvAvKv1rHDnWs+DYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766371737; c=relaxed/simple;
	bh=0m+pcDn1Y4QSRuAPXVBQkxrWftTQwI+SMqc6yp0+T+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ+HxZI/ccO5tqAPwPtT7Vp/W9u2xv4cWmx/DgydQGkShxEE7Ff2Ao3BpkDum9W7Ixiq/VNaha1fOn6BTBzWyMxl5GuhqfyCCzZH7gmdQlPS+XXMV9EqgMYpRJzuyxn3g/QIjbboKWBLJ7QPZjg6lzrwwAjQA16PwBPwmeKJWak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fB4U4fR/; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fB4U4fR/"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b66d427e9so20002a12.1
        for <fstests@vger.kernel.org>; Sun, 21 Dec 2025 18:48:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766371734; cv=none;
        d=google.com; s=arc-20240605;
        b=ZCqZVYCqA4XmAI+4XxcWL8BcuHo/xbLTJg3iVfBr+w7GpvdvMr0ZxF9VbSlmsIapfa
         W+RxiX+eJeKlMyWv8stq0Cw7LDhTs2594jOkVq0xgIJgF2KMVL5F+z23bebgsTL0ByCx
         1g/G9echgJ49MSah6MOhE7Bt+/7RLs7v0WMYuTqR7dG3HHtITGRgVgDisjIMxMCRDwGt
         YgI994excDcD+HfGTgbRmlEkGGNpJUU0KfJMHtGxfB2T2PS2JZK/c3b2fyGftrGzjd72
         E4K0uf4Lovau3z1z9arkaPaPhdpcdMhsS7jMustXvzX/XKGh7Aeo2MFtLdoq0bWZzMSo
         6ybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CwSTfOK2PQKjAWo+5ivUdXM7DoFjB7pfUDLS+oPx57g=;
        fh=hvJsa0L+2zEMHdtRM2MSciVWG6fhZj17JPNR++DPRk8=;
        b=Bfp9Ani9wmdr+36AdS/0WpSxmaEgY6cVpWRh8p2RhJLoBooxIHr7+nGmwsTEmQ7HYI
         D8gPBhGv6SZlmleLF4Mj8VCEJmnkQfhFwkaGJ1treYduq3KEu7e3MuAx3AcEg4U3zjMS
         TS3O/jTk+EVOjpxrUO1KYS4VGRafo3np8+ValKXxnBenyV29A3N/a3gd5H3zzs8IkUSr
         nmclj7qjR/Y60E9Vu6OXxwq+qykk5BwRj/06Iu9X2nG7XWNh3dHsf6KUB0AV1CHfzIub
         lwr7eQIQLCuwGcbeu8K2rtKzdSypZLZ2k68zVrzaSD1wYTEqF8Ulk/yeTYS4LE/umySd
         EkBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766371734; x=1766976534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwSTfOK2PQKjAWo+5ivUdXM7DoFjB7pfUDLS+oPx57g=;
        b=fB4U4fR/rmslyoD1cwKryzwn8Jl3yXNzLGnE8KMKwiyqdOwflkfsfKdXxUSzD4nM/d
         2yAu+5wgiQzuE4vQl683XnjHsMbclI02ALWvxo5mBmpjN1Nz/4Ip08j9/HaDLSMnjHZU
         J26SYXmvycWhmY50bUr1udHD05aegPgYefrNvNsFiek5uPSX2W7lXaLqhEhjFkQdVKEF
         Cu5je2tjqZxiYFSx9MAPgZ5LRHkiWdlOQlqHi+EG3u516hZcDt3MKaPUg6IjPnIML6pb
         Mt9HWsHzGynqXBXWIwyhbm6n+bhLQxCz2Kl+hv66DYLmNFpTY58g2Ve6Sg6vWrz3s06A
         Fojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766371734; x=1766976534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CwSTfOK2PQKjAWo+5ivUdXM7DoFjB7pfUDLS+oPx57g=;
        b=N3yVkIM3oU83QoD4duGVcd7J5FvGXnDlDLo2LuTCvMiN0+FqMegdx3Zlys9COn9c6R
         LytaeAbvgxGtYGjbwNQvgOUh0Ovpblp77P9qJzthNtAyHKATjxOh7FYupoOg3XqK3nx0
         csG4VPtHXPCT0JSLIjjJlg/OeEY4S1LEdJOyfXVHu98WAxMpOhnQO05m7ZGnDBZTqNho
         +lTvKaAHKzmL7FFr32pHS0kyXLx9SDVa+YlifmP8Yyx95LoE2fw6xHLqrhEZ5DNK/zmh
         gQ2eNcbaPpNvA85FXmcEXG8VJTJUjgEMT1rkNVaQgYXGsupyxIJ3UQir2YSYwuPrdVp9
         XPfg==
X-Forwarded-Encrypted: i=1; AJvYcCVOznbg5uV3Rl7x7Jn+Tn7ZvFUj9cqgVHTnTrYbBAHCWW7iY5nwBsEJJSfosAYdcAk4JvTE4sal@vger.kernel.org
X-Gm-Message-State: AOJu0YwI3lJuSPWStoGEJdbahMa9HO4TRXNyjUCYnS6vrHJ4OqTmxVy1
	RGUueKPhxMzJFsJrb6omkHDJqk7bBSMWa/ftHWbanlAZiajMBpDk9bx1cavhni2WQO7h0JolgYN
	CNSqhw1Ig+WMwrFvcl7ZexqJnywnYW+OzHwzTjEOE
X-Gm-Gg: AY/fxX4TRWUotHzzX2HO2PET0LYKb/LGCBXDw3DC5QuV8g2IOHhF4z3mflHUO+Y2HNq
	PaUdmJUbWrSFWZmE6p9c6bulcN14gdlkv5lZCOYRqE1mSXBoD98rEsft3mN+TcmmPWQw6MVou4g
	iI4w/e3Bsz2vX4plXYSNszxYiwav938imhRB3ElY9za7gaX4CsPwAtleS7GoKgSSjqP51S6lSyA
	gPPT82jD5bM622vQZylY5cRTntaIlUyKxkQHNTYbJPEyLquGT8hYmuotYlzzgHXNJDxtwgg0uWb
	nGv+mzcCnVtJFhf9710PQV2keZG6WuaN4p/E
X-Google-Smtp-Source: AGHT+IGICnv+CNulcBUQj4EVMqHrV4XCI9DVrr3ZNtTi17PvRnxG9nGncqdET6iqs+YBkatoM7bhDOnN+T+cZex2OlM=
X-Received: by 2002:a05:6402:1753:b0:643:6984:cee9 with SMTP id
 4fb4d7f45d1cf-64d065c43f6mr35946a12.12.1766371733804; Sun, 21 Dec 2025
 18:48:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218071717.2573035-1-joannechien@google.com>
 <aUOuMmZnw3tij2nj@infradead.org> <CACQK4XDtWzoco7WgmF81dEYpF1rP3s+3AjemPL40ysojMztOtQ@mail.gmail.com>
 <aUTi5KPgn1fqezel@infradead.org> <CACQK4XCmq2_nSJA7jLz+TWiTgyZpVwnZZmG-NbNOkB2JjrCSeA@mail.gmail.com>
 <aUUymqMO4RfK8thK@infradead.org>
In-Reply-To: <aUUymqMO4RfK8thK@infradead.org>
From: Joanne Chang <joannechien@google.com>
Date: Mon, 22 Dec 2025 10:48:37 +0800
X-Gm-Features: AQt7F2p6Hjd_Nc7T5OEAyJgKQ5pr8sxJsosqYLA4O1HbB9YpKCqF7Pm762ItbGg
Message-ID: <CACQK4XAyDLfOcPWpRzKd+VXA5EtvzVNkxrZC9hjNJjx0uHx=Tg@mail.gmail.com>
Subject: Re: [PATCH v1] generic/735: disable for f2fs
To: Christoph Hellwig <hch@infradead.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 7:10=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
> Well, for the file size you can test by doing a truncate to the expected
> size and _notrun if not supported.  I can't really think of a way that
> easy to directly check for the number of supported blocks.

I guess we can calculate the block limit by _get_max_file_size() /
block_size. However, I am concerned whether this method might mask a
regression that reduces a filesystem's supported file size. So I
wonder if explicit, hardcoded limits within the helper for known
architectural constraints (like for F2FS) would be safer, as we can
ensure tests are only skipped when the limitation is intended.

Please let me know if you have suggestions for either method.

Best regards,
Joanne
