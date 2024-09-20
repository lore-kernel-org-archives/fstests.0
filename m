Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981205339F
	for <fstests@vger.kernel.org>; Fri, 20 Sep 2024 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726827171; cv=none; b=frd7KXHd8gzJa8unwSdvg+xUjXGtYfR9PyhiUuFtP6PLs4SYukBZFW5sd9qI3QdSImtYNbCkUl2hfJmjDmocYhq8NA2bjINKybTVRYG5HndNWSqhCLwKT2G2D8JJgmsumq9W6BmSedMzyt53KclwK8SsrSVkRrjCOgqS9lThN2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726827171; c=relaxed/simple;
	bh=z3/yHUlfJqo/IvDAJ9MymrKckGEFHiYoWtH+krDoHl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMbCx8w4mE88s6QWJ5xou370xxV5msN01b+HdIKo0yvlmAvwXLqA28w0BSa2Qm0RIIY+UtA5Mjf/AmQ2+NT5Ag5idyecpz2dXTYkENtYwLIRYtZJBjt3BC7qGKKmw3KSjIgZHLX37+YWLtT6VMWLaLe4r+9JoI0GvHkzbR95sS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naoiAKgY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naoiAKgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFE1C4CEC3
	for <fstests@vger.kernel.org>; Fri, 20 Sep 2024 10:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726827171;
	bh=z3/yHUlfJqo/IvDAJ9MymrKckGEFHiYoWtH+krDoHl8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=naoiAKgYuSOtvmI1xSWV5tk/LxFY3P5FZO4fw+EuzaZYNUCEcT67xddlYQbgGvEVb
	 ynh7kJM4Y1Af71rYJB3nq5Rvpkod47uxDq1cuxwBGCWSn2paVEMx8DaNZ2AZEdbwbZ
	 W0ZDu/YdhbVzf5lLvfRHmQ2EwZI5Sbx3f8csiWDBXmkpHIAXfQG+bzSSl924zZtbhD
	 BGq/VV8VJn89VZ+Uh+iEWIwS6Wus+6u+YeU3Yfaf1J44fuEu96JeXinperOyJE3p6f
	 Y1yWwGk9ZfMuq+7l4zS3q5NXxx9y3hMeBm4wxb51LZFkOfUYhSNo1TbdNlgsnsLsy9
	 s5jkhGq83EUEw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so2379862a12.0
        for <fstests@vger.kernel.org>; Fri, 20 Sep 2024 03:12:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXI31j9YHGL9cdfZmiC8gGIbJm6lXIWY5bzpTqpwy0dPpZ97AhR0x+/rfJP0zF9J5QKf6EBbg2g@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8x7KUPj2+JM3OLU4N6hgJPUyxmiBL1b5qCqR0Z0INI2D2Xkfb
	JDC+u4XkPkORY4llhTvrAkF2c78u86cp7F0+KQXAQuBuThw/908gnvr4W+QInC0y2lRXx9b+y59
	CbIX5Y005AJSuwl0FCdKf5O/0fXA=
X-Google-Smtp-Source: AGHT+IGy+FJYVSr66GwoR4+MTpGE8DTVsT3hmVDYrMK2wIIpqp+Zba4LxOGwXFPVNGoIhpE5mZ62Zf4RUw093k8DDT0=
X-Received: by 2002:a17:907:e216:b0:a90:3517:6b1d with SMTP id
 a640c23a62f3a-a90d577a1famr181415866b.48.1726827169751; Fri, 20 Sep 2024
 03:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bb85eb7d443b2da482b6087d8946f0efafa15f87.camel@suse.com> <20240919120156.apamqapyuytpf3ii@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240919120156.apamqapyuytpf3ii@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 20 Sep 2024 11:12:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7VvysO7S6DxOUwoR-1TWT61NAeHBVcidZca_yiT+q3BQ@mail.gmail.com>
Message-ID: <CAL3q7H7VvysO7S6DxOUwoR-1TWT61NAeHBVcidZca_yiT+q3BQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs/315: update 315.out to adapt mount cmd
To: Zorro Lang <zlang@redhat.com>
Cc: An Long <lan@suse.com>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 1:02=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Thu, Sep 19, 2024 at 01:07:53AM +0800, An Long wrote:
> > Mount error info changed since util-linux v2.40
> > (91ea38e libmount: report failed syscall name).
> > So add "mount" before "system call failed".
> >
> > Signed-off-by: An Long <lan@suse.com>
> > ---
> >  tests/btrfs/315.out | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
> > index 3ea7a35a..a19ae8d5 100644
> > --- a/tests/btrfs/315.out
> > +++ b/tests/btrfs/315.out
> > @@ -1,7 +1,7 @@
> >  QA output created by 315
> >  ---- seed_device_must_fail ----
> >  mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-
> > only.
> > -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
> > +mount: TEST_DIR/315/tempfsid_mnt: mount system call failed: File
>
> This change will bring failure to downstream distro. Please refer to
> _filter_error_mount (or other filters you like), add new filter to
> it to help this test passed on old and new util-linux.

Isn't that what I said in my previous reply [1]?

[1] https://lore.kernel.org/fstests/CAL3q7H7fzCQE0qjZEgeAJ2jvBsJxbYN-S=3DXp=
WFu5KDoaXgqsZQ@mail.gmail.com/

>
> Thanks,
> Zorro
>
>
> > exists.
> >  ---- device_add_must_fail ----
> >  wrote 9000/9000 bytes at offset 0
> >  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > --
> > 2.43.0
> >
> >
>
>
