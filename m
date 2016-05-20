Received: from mail-ig0-f169.google.com ([209.85.213.169]:35196 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbcETRA3 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 20 May 2016 13:00:29 -0400
Received: by mail-ig0-f169.google.com with SMTP id bi2so140995644igb.0
        for <fstests@vger.kernel.org>; Fri, 20 May 2016 10:00:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <x49r3cwztb9.fsf@segfault.boston.devel.redhat.com>
References: <1463696380-20169-1-git-send-email-tahsin@google.com> <x49r3cwztb9.fsf@segfault.boston.devel.redhat.com>
From: Tahsin Erdogan <tahsin@google.com>
Date: Fri, 20 May 2016 10:00:26 -0700
Message-ID: <CAAeU0aPk-gdP3hTPXi7_KuEYH4DUvn7OSpMo-76t1m2WsJfkDg@mail.gmail.com>
Subject: Re: [PATCH] generic/208: do not leave pending async ios behind during
 process exit
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

On Fri, May 20, 2016 at 7:40 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
> exit_aio will wait for all outstanding I/O before it returns, so you
> shouldn't run into this.

Thanks Jeff.

I was seeing this when running generic/208 on an older kernel. I see
that it got fixed in more recent kernels:

commit 6098b45b32e6baeacc04790773ced9340601d511("aio: block exit_aio()
until all context requests are completed")
