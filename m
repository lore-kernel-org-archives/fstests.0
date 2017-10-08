Received: from bombadil.infradead.org ([65.50.211.133]:52818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751476AbdJHJEF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Oct 2017 05:04:05 -0400
Date: Sun, 8 Oct 2017 02:04:03 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] holetest: Use pid_t type for fork(2) return value
Message-ID: <20171008090403.GA22995@infradead.org>
References: <20171005194826.GB21115@infradead.org>
 <1507277986-17326-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1507277986-17326-1-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Oct 06, 2017 at 08:19:46AM +0000, Rostislav Skudnov wrote:
> ---
> Hello Christoph,
>=20
> I think using uint64_t is fine since pthread_t is either a pointer or a=
 ulong,
> and pid_t is an int, so uint64_t acts as a "superset" of those types. V=
alid
> PIDs are positive, so the difference in signedness should not be a prob=
lem.

Well.  For one it loses any type=D1=95afety, second uint64_t is not
guaranteed to store a pointer (although in practice for the platforms
xfstests runs on it does), for that you'd need a uintptr_t.

Anyway, as a quick fix your patch below looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although I still thing that code is extremtly badly written and using
proper types to store a pthread_t * vs pid would be a good idea.
