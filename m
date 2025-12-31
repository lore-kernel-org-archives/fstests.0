Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2612857F0
	for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767206468; cv=none; b=g6zuPkjYC3BYWTiHxmXcuJZbwiy7xb8gE5aIKs4IQHOQZ+6mn1KyOxsgy2sfRtEANRkjpfwfMdate2LL/B7qbqUuCszg3Rgl7U9Cm3P/KATSvP8kUNSuaBBzNKvlcGTyhjpTGNKnqjTkBeOPtREDuDswRDuJrBAXhblue+TJtJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767206468; c=relaxed/simple;
	bh=Kz1dHimfq3rgUsp8HeeM57OwRpn3yogNY7NyaIBHcYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoDSBqRe5poUMD8MDx4GPbugLHjp35hHWV/rxCKJ+9Ma93GqA7PJJDN6F2rMigcxk1QhSKSw8BRd7yYlAfpf0WHxwgG4VeCCUYcn5zDFaWQd6E5fms79cAueMZqhhPhGz3JMH2dQLN5G6BGjx8lNwRXUkPvRnQ+iuhxnWk+1hto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B37n23q/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlLLfjCe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B37n23q/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlLLfjCe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767206463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1j8W/LCdoALIFv9dH52TsZMIYdWJGl1uGlRBzrcGvU=;
	b=B37n23q/o/9jIBTgP9StTmkXr5++Bo5geV4L5NmfV84rLseL1909sknNvDKsk/tDyg0Uup
	xCZfwaSujqR2P4T5EN5nnyeznn4zEIaOf7YOuAnZzDdSCpswh8KbV51S9sR5uQNd/qTrON
	x7otj82xZHzWeS5Uyr1+UnL4yhMSln4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-RDVCChLjNJyA1vHbPKg_HA-1; Wed, 31 Dec 2025 13:41:00 -0500
X-MC-Unique: RDVCChLjNJyA1vHbPKg_HA-1
X-Mimecast-MFC-AGG-ID: RDVCChLjNJyA1vHbPKg_HA_1767206459
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c1d27c65670so5508544a12.1
        for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 10:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767206459; x=1767811259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1j8W/LCdoALIFv9dH52TsZMIYdWJGl1uGlRBzrcGvU=;
        b=NlLLfjCejZXmgNiITz8YlxXfo6sc0iSpXclIDQGoq9SJJpJIDL+XodQ9feuQaiqW6Z
         e4uERb0U/oWokFNo0DlEit2cDyEwEtDW2ZIyfPLU5prkqpzubZ1izxbdGQVZvX9sM+L7
         60ZmA/MYgfbBc6BcUIYaGoIZILdcTr8FtO34d6eMNiCOHoWJS6qwc9hAMb8LqD/bO7MX
         1ZaaLj4PdTVcxPywq5xVUkL7HRCoPM3KznN/I8AADIV7hIotXfLPKribu7EeUQovbRwI
         6Jp+iOCiqL5WLrlqTjM6JBN4A1Dcr5px9B15CPA/wEOUzxcnn49FSSzVq8cmMW8AbhZB
         1QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767206459; x=1767811259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1j8W/LCdoALIFv9dH52TsZMIYdWJGl1uGlRBzrcGvU=;
        b=vKPcQL66AA8lSlJUY987j+lKSwLl6iVMQWvTc1jfu7UwLBDoIWn0oQ0fJ886iwcSgN
         EdIxUnmtI7on8otQL5HvWV5AvSqwdW9yDtI+YjzYalWql+Ypth+BpTQo8R+b1OmM6+6x
         oeIlwf9KOhgmppajrrk3N7ukcJIKWrrx9r6ECfxu0jEIqbnxZgkpj61wzXtnXDoZRuf5
         +I8MAMC5qEvN4auqyN9VvW5lSDebDaK6kRv4X3ZpRNu3Yve9BMIXBKbTz7FfQZtlSkSN
         1+u/+QNjGg6nVTVX2a/UKW7nM3dy+7qrVlSFpK5LD/SKl3ko9Va0E2akPrnAznbuCxc1
         QRtg==
X-Forwarded-Encrypted: i=1; AJvYcCUvSEhHQAarT/UG0hFvALTQAGHYofpwZtzHoaciJotdIkeI3+IqyrXGTKPCzRkVMZwzJ+tTlASZ@vger.kernel.org
X-Gm-Message-State: AOJu0YycUl9Q4YfoG7JRVhPIFNcjRfDBR+vWdSjRVvhKElaotu2O89+r
	OVwsNxgYEwQAw1RxA2NK3wST0YznGJYLCHPNO3BQOhKSK9zMe/Td/ELPaM/NO4DiiNvwMXglOUw
	pOPIU46zmpYGIRLJNp3S9GM0Dv++Wu3WFD/+WJhKaWjSIzyKXzGKYbPiXriI=
X-Gm-Gg: AY/fxX4BU0y26P5GCRcKnMbehGTeiw4LKAqx3cpIwW+aX1pRWuVBewQcew2XoIjVZjM
	GnJzjL64dPlRfb6lCubH9apHvf2jnEKu5EuxujEp0kq8tklDzHQfiJ3TCjRD1qbukBU65OJaArJ
	ey1A0E1kCJMs8DbiBdRN+57cmWK+OtX8xSDXKk4aUdFmJYmTbrd36RMycKFphPm+YZcvkZV/bma
	4TJ1hWji5wfD0UJ5hAzxqIUxlXQNwBm/gtbHxF982pJ7y33Agw1rNYQufRzlO2IeBCvszdcBKg+
	X2LCMS+0uv8Pu5MTaGzqYYNp05D+0E9llXJciSY6QoHNL3jluUcPHrSbl6KKeWMLcpwugWdUzz9
	ilP9ri8tenYCQ8HZaURduf7ec7KuCcH9QUbOK21f34OuX30Ei0Q==
X-Received: by 2002:a05:6a20:a11e:b0:366:14b0:4b15 with SMTP id adf61e73a8af0-3769f933424mr33382725637.32.1767206458838;
        Wed, 31 Dec 2025 10:40:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0G5u2EJTc9yLi8UZzzUWVYMTmjBf5F5UP/yTwBqGElOJytHoKGNWT2d7fDLVDwi26+Vo0HA==
X-Received: by 2002:a05:6a20:a11e:b0:366:14b0:4b15 with SMTP id adf61e73a8af0-3769f933424mr33382706637.32.1767206458296;
        Wed, 31 Dec 2025 10:40:58 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a8442edsm36022196b3a.12.2025.12.31.10.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 10:40:57 -0800 (PST)
Date: Thu, 1 Jan 2026 02:40:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: upper vs. lower case hexdump vs od on current Ubuntu causes
 generic/029, 030 and 031 to fail
Message-ID: <20251231184053.taidcweyhrwxleeu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <CAH2r5muo2jWVkqAwnT-NNPpYeA9P6WHq6Jic-g6r3NM3-+eq2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5muo2jWVkqAwnT-NNPpYeA9P6WHq6Jic-g6r3NM3-+eq2Q@mail.gmail.com>

On Mon, Dec 22, 2025 at 06:33:41PM -0600, Steve French wrote:
> I noticed that tests generic/029 and generic/030 and generic/031 now
> fail on current Ubuntu (Ubuntu 25.10) due to a upper vs. lower case
> issue in dumping test output (hexdump/od). This is testing with
> 6.19-rc2 but it looks like a change to hexdump or od that likely broke
> this.  Any ideas?
> 
> See e.g.
> 
> generic/029  0s ... - output mismatch (see
> /home/smfrench/xfstests-dev/results//samba/generic/029.out.bad)
>     --- tests/generic/029.out   2025-08-22 09:54:32.256748004 -0500
>     +++ /home/smfrench/xfstests-dev/results//samba/generic/029.out.bad
>  2025-12-19 18:25:13.562003626 -0600
>     @@ -42,10 +42,10 @@
>      000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >WWXXXXXXXXXXXXXX<
>      000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
>      *
>     -0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXXXXXXY<
>     +0007F0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXXXXXXY<

Hi Steve,

Sorry for this late reply, I just backed from holiday.

What's the version of your "od" command in Ubuntu 25.10 ? e.g.
  # od --version
  od (GNU coreutils) 9.9


The hexdump output is from the common/rc:_hexdump() helper, it actually runs
"od -Ax -t x1z ..." command. If the output format of latest "od" command is
changed, we used to use a *filter* to help the output to be compatible.
For example:

  _hexdump()
  {
	od -Ax -t x1z ... | awk '{$1=tolower($1);print}'
  }

If you have a better idea to do that with a simple 'sed' command line, that
would be better.

Thanks,
Zorro


>      000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
> 
> and
> 
>      80 generic/030  0s ... - output mismatch (see
> /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad)
>      81     --- tests/generic/030.out   2025-08-22 09:54:32.257748640 -0500
>      82     +++
> /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad
> 2025-12-19 18:25:14.073196575 -0600
>      83     @@ -4,50 +4,50 @@
>      84      ==== Pre-Remount ===
>      85      000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> >XXXXXXXXXXXXXXXX<
>      86      *
>      87     -4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> >YYYYYYYYYYYYYYYY<
>      88     +4E6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> >YYYYYYYYYYYYYYYY<
>      89      *
>      90     -4e7000
>      91     ...
>      92     (Run 'diff -u
> /home/smfrench/xfstests-dev/tests/generic/030.out
> /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad'  to
> see the entire diff)
>      93 generic/031  1s ... - output mismatch (see
> /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad)
>      94     --- tests/generic/031.out   2025-08-22 09:54:32.257748640 -0500
>      95     +++
> /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad
> 2025-12-19 18:25:14.411496471 -0600
>      96     @@ -6,14 +6,14 @@
>      97      ==== Pre-Remount ===
>      98      000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >................<
>      99      *
>     100     -01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
> >................<
>     101     -01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> >................<
>     102     +01F860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
> >................<
>     103     +01F870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> >................<
> 
> 
> -- 
> Thanks,
> 
> Steve
> 

