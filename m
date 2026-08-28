Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923553CB8E6;
	Fri, 28 Aug 2026 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787915569; cv=none; b=ZIswn4L37nlsYtE3s8p21kMvmxX4LAMU/DKouJFOF+mhEuevoTLQbxl7xajpqIw8cL94nHpNfe05CylL76hajL6r2Ke6PqXfH6WmtrgjLYs4dAbSEk6LYQOE7C/6AbsvpLERN+UlylUuCcAbC0ZmtUZdE+uqHY0NENIPUNCMRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787915569; c=relaxed/simple;
	bh=ZQJPaBG5y3MKHtQkLbGNu7EJQPKoq+D8lq+I91ksITo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ghWA0mtE5z4BdsIWPcTL8DkksQgNJfTHnXGJ+rJFy8qTnmcnBHWaNEaIXGczHDeH1FztQgyfoGMvWpdTfx8nKwaUwwHjEq8grdTR3DH2qf5kwlIB8zfs5Z76yKNI+xFxzeEJc8zDXxDB/Y/Rtbnqtv37Cj24nSxB+dP2J+hyh4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=QSS5pJsu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AysqNg9r; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="QSS5pJsu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AysqNg9r"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B854A1D000EC;
	Fri, 28 Aug 2026 07:12:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 28 Aug 2026 07:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1787915566; x=1788001966; bh=LskiHz1h292IUODVBCAEDjmHPu55Af+JJqk
	YibvLudo=; b=QSS5pJsuVOSk0TaGFjHQLYEh3CkjWuJoC64hXqiQCrB4QQPC2V7
	UxYwmjE6pLend4ZfBhFHB3Xf5q5LOIQhnBNVNnaSkkJHc+D9ALcXfpsE+oVgZzY8
	AnL9wgNH9IeBAxnZcqnGJloV3LG22RTcyb5epujU7fnbq8KNQHaDnWZdKaC5gI1j
	4cP2u0XAPt39PXSjaf3Qwk7Z0bDSOAAo57eZMqoUdT3TOYC+AYdv0C4gL914oyfG
	Pj3ZVcw5lEehAioPSPNmPrKJanfmDzwPY6rWTENpSnOJn61JCgbSoho7koorwqTK
	CqeV+GYL1KIr2OlDMqJeAltbQUCa/gSsnOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787915566; x=
	1788001966; bh=LskiHz1h292IUODVBCAEDjmHPu55Af+JJqkYibvLudo=; b=A
	ysqNg9rzvp/3jPhk9bgEml3DxKC7ZYXYWBps/mVpiOw6gS6qoy/Zi1mYUa45hHhk
	WZ2oi9K1uD33mxnoIH7T5ldsNmII+8ArBOEzUONDYSo+R9DUnnZPIi4mJHQJOwVH
	rh4rUS3iGSY0cwoaS5a/p9FotZeVXuGMGeyUXlwTfeJVuT3tOOMHQZ7RTyi0sh68
	bIG0eh1oyaklqajM8Nght1h8GHHarisHhwehPwyERYWTYyNBtOzRjjRSUZrYb1kw
	wiVgU7ixHASkVrSuykhTc/cOawo5inocvg0YEr+kkDPMfXInG1IMuR2Pe39+SWTY
	UfJ62ANebRhy/OqETz7LA==
X-ME-Sender: <xms:Lm2RajYsh_miA0O6JhLelX3oTRjMfmCI7rwGqcWMCf7qNEYgwzQ3Jg>
    <xme:Lm2RagNlLh8u3UvnB_twBDURMbi7KAA2RGB13VljVD2tRfzdk0nWV9X3_eUljr1wH
    7CO6icdtYdjA3aKxcZ070AHqXL7wEy3GXLyPV8IK8XomyuQ-ns>
X-ME-Received: <xmr:Lm2RagbqhlvqZdyheNsZbotV_Ju6eb_z7SgilyMFeKFWNI_42BQpheS2hv5k2HRe0g>
X-ME-Proxy-Cause: dmFkZTGNQzwU/BJDdO8A9I7c8Ub9+j0LIvU55nGFpuWwAx/C1/cR3EB1RcGc05nZ3EjZOV
    97sDoVbheSFqaBthnXw8SJPIj2Yjo1Xo2VSPLPEjIZxE9UBA79UKJ1+obdWFSQ2SU51IFL
    DfrE1ARWZ8V1HEEn4LvfIELcedsaGiVmVYrDxLLhvTCZ7iAVzeAZmjUs7DSGmR2I5Y8PIF
    hVk0m97uH/uHyQQKhum9w4/wXMMSsacfYlvuVmUDdpRZnoYOeJ0ffhl2laW2G39e8f54ye
    m6UkDTmn50oYYkjJdIe7VkxYWJfBeJXhcYEuPirCj0xfWNhKUuvAxQsZOYzlxnWGUIFvmk
    kEa83upsVjuVmaT6kuh5nyMV7Ze28TMgeuPwsR/YeGZxw+L/ERNHYeQ4Hexpe+QJ1coRJk
    525p34HPsVbqwjJIOyqnShKjIZWDGzY6RX8izkuisJkrDWk5kkYhXBr9MBQO/ojPAVBjpd
    5XBx2ZqSnIZTerNkPAGr1vvUjVJ7g8KPxRG8VqMpa3fewivc2Kbj4UfBIm+3psW4wXOl+H
    L6NoaZf/MrAnE5htVpOO5JLRMb+Hrqr+TF6UDlula+xXEbahokCaJ5vZg9PDOSBCFUCwnE
    fpJotZE9gGsuXV9QqIVm/GfKvSLP0m3K75NgqU4FiNLoqsZkrkQDWy5sBr6A
X-ME-Proxy: <xmx:Lm2Ram1W0W5I4wIkMIfOzQz2hq6B34m1WWl-h84aEEwvRtB6_9M5PQ>
    <xmx:Lm2RaufNLv20ouhK1twuTwLvctbUEvppMRmAHWU8jPgP3apVaqjF5w>
    <xmx:Lm2RavEbDBiTPWKgORhRt2-nMRNPW2cjmFIvh9pJ4Vb3n5ij2YONFg>
    <xmx:Lm2Ran3-gIF_bIktHgW_CNgR2S3Iew4z9RwNveuNdEhDZ81U-2ZjIw>
    <xmx:Lm2RargO3yUvLKNOFOGqpWBOL-9cBNu_l4Mnol3OWo7M1-99sKW0Ojjc>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 07:12:44 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Matthew Wilcox" <willy@infradead.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Chuck Lever" <cel@kernel.org>
Subject: Re: [PATCH] fstests: generic: Add test of seek in directories
In-reply-to: <apEK5uirjyLZUfmA@casper.infradead.org>
References: <20260827234743.2389778-1-neilb@ownmail.net>
  <20260827234743.2389778-2-neilb@ownmail.net>
  <apEK5uirjyLZUfmA@casper.infradead.org>
Date: Fri, 28 Aug 2026 21:12:41 +1000
Message-id: <178791556100.3510150.18132687067056760170@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 28 Aug 2026, Matthew Wilcox wrote:
> On Fri, Aug 28, 2026 at 09:36:10AM +1000, NeilBrown wrote:
> > Add a test for consistency of readdir (getdents64) results.
> > The expectation is that name which exist before a readdir starts, and
> > still exist when the readdir completes, and which have not been removed
> > or renamed away and re-created, should appear exactly once.
> > Also if the fd on the file is closed in the middle of a readdir and
> > re-opened with a seek to some offset previously reported, the same
> > sequence should be reported as if the file was kept open with no
> > seeking.  This last is important for nfsd.
>=20
> I'm not sure it's required by POSIX:
>=20
> 	The behavior is unspecified if lseek() is used to set the file
> 	offset to a value other than zero or a value returned by a
> 	previous call to lseek() on the same open file description."
>=20
> https://pubs.opengroup.org/onlinepubs/9799919799/functions/posix_getdents.h=
tml

If you happened to know the sizes of the all the names in the directory,
you could make a sequence of getdents calls which each return precisely
1 entry,  You could then use lseek to determine the seek offset at every
point.
Linux getdents64 makes this a bit simpler by returning exactly that same
number (the seek offset to the next name) in the d_off field.

So posix certainly allows, indirectly, seeking to each d_off.

Posix refers to one directory entry "immediately following" another
which clearly implies a well defined sequence (if you exclude names
added and removed during the read).

Also glibc currently expects exactly this behaviour for implementing
telldir/seekdir.

>=20
> We can of course require stronger semantics from Linux filesystems
> than POSIX requires,  We should discuss the benefits & costs of doing so
> (and I have no idea what the costs to btrfs or tmpfs might be).
>=20

I think a strong argument for Linux needing something is that NFS needs
working directory offsets to be able to support READDIR, because there
is no "OPEN" request for directories.

I agree it would be good to discuss this and hear other perspectives,
but I cannot see a lot of flexibility if we want a system that works
consistently.

Fixing tmpfs is easy.  I have a patch which makes it work much better
with less code.  Chuck quite reasonably wanted some objective measure of
"better" and suggested I write some test code for fstests.  Hence this
patch.

I know less about btrfs.  It appears to always add new names to the end
of the directory listing.  When you rename over an existing name, that
existing name is relocated to the end.  I can only guess why it might do
that.  I have no idea if it "needs" to do that.

Fun fact: This behaviour of btrfs (which I think is perfectly defensible
for new names) resulted in generic/736 (which I think is an unreasonable
test to impose) which btrfs "fixed" with a mechanism that doesn't work
over NFS.  i.e.  it doesn't work if you close and re-open the file for
each getdents call.
If I mount a btrfs filesystem over nfs with rsize=3D4096, then generic/736
fails.


The link you provided says:
  If a sequence of calls to posix_getdents() is made that reads from
  offset zero to end-of-file and a file is removed from or added to the
  directory between the first and last of those calls, whether the
  sequence of calls returns an entry for that file is unspecified.=20

which unfortunately doesn't cover what happens when a file is renamed.
When renamed to a non-existing name, it might be reasonable to describe
this as "removed from" and "added to" so its appearance could be
unspecified.
When renamed to an existing name, I don't think it reasonable to
describe the target name a being either "removed from" or "added to" the
directory.

Thanks for taking an interest,
NeilBrown
