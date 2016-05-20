Received: from mx1.redhat.com ([209.132.183.28]:43362 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754091AbcETRV0 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 May 2016 13:21:26 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] generic/208: do not leave pending async ios behind during process exit
References: <1463696380-20169-1-git-send-email-tahsin@google.com>
	<x49r3cwztb9.fsf@segfault.boston.devel.redhat.com>
	<CAAeU0aPk-gdP3hTPXi7_KuEYH4DUvn7OSpMo-76t1m2WsJfkDg@mail.gmail.com>
Date: Fri, 20 May 2016 13:21:23 -0400
In-Reply-To: <CAAeU0aPk-gdP3hTPXi7_KuEYH4DUvn7OSpMo-76t1m2WsJfkDg@mail.gmail.com>
	(Tahsin Erdogan's message of "Fri, 20 May 2016 10:00:26 -0700")
Message-ID: <x49twhswsq4.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Tahsin Erdogan <tahsin@google.com>
Cc: fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Tahsin Erdogan <tahsin@google.com> writes:

> On Fri, May 20, 2016 at 7:40 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
>> exit_aio will wait for all outstanding I/O before it returns, so you
>> shouldn't run into this.
>
> Thanks Jeff.
>
> I was seeing this when running generic/208 on an older kernel. I see
> that it got fixed in more recent kernels:
>
> commit 6098b45b32e6baeacc04790773ced9340601d511("aio: block exit_aio()
> until all context requests are completed")

OK, phew!  Thanks for the follow-up!

-Jeff
