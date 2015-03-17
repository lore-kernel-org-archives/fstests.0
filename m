Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:58477 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbbCQPd2 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 17 Mar 2015 11:33:28 -0400
Received: by mail-vc0-f170.google.com with SMTP id hy4so229158vcb.1
        for <fstests@vger.kernel.org>; Tue, 17 Mar 2015 08:33:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150316232434.GJ28557@dastard>
References: <1425909612-28034-1-git-send-email-drysdale@google.com>
	<1425909612-28034-3-git-send-email-drysdale@google.com>
	<20150316232434.GJ28557@dastard>
Date: Tue, 17 Mar 2015 08:33:27 -0700
Message-ID: <CAGXu5jLfrGrVO=9sF6=TK0QQHq4SWRjL0urGu-e+e1H8gk9Y3Q@mail.gmail.com>
Subject: Re: [PATCHv3 xfstests 2/3] generic: test openat and new O_BENEATH flag
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: David Drysdale <drysdale@google.com>, LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, "Eric W. Biederman" <ebiederm@xmission.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Meredydd Luff <meredydd@senatehouse.org>, Will Drewry <wad@chromium.org>, Jorge Lucangeli Obes <jorgelo@google.com>, Ricky Zhou <rickyz@google.com>, Lee Campbell <leecam@google.com>, Julien Tinnes <jln@google.com>, Mike Depinet <mdepinet@google.com>, James Morris <james.l.morris@oracle.com>, Andy Lutomirski <luto@amacapital.net>, Paolo Bonzini <pbonzini@redhat.com>, Paul Moore <paul@paul-moore.com>, Christoph Hellwig <hch@infradead.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Linux API <linux-api@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 16, 2015 at 4:24 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Mon, Mar 09, 2015 at 02:00:11PM +0000, David Drysdale wrote:
>> Test basic openat(2) behaviour.
>>
>> Test that if O_BENEATH flag is set, openat() will only
>> open paths that have no .. component and do not start
>> with /.  Symlinks are also checked for the same restrictions.
>>
>> Signed-off-by: David Drysdale <drysdale@google.com>
>> ---
>>  .gitignore            |   1 +
>>  common/openat         |  61 ++++++++++++++++++++++++++++++
>>  src/Makefile          |   3 +-
>>  src/openat.c          | 100 +++++++++++++++++++++++++++++++++++++++++++++++++
>
> This strikes me as something that shoul dbe added to xfs_io for
> testing, as it already supports a heap of other open flags and
> xfstests is already dependent on it.

While I don't see a problem adding this to xfs_io, I'd still like to
see this test live in the kernel tree too. Having it in the same
source means more testing, IMO.

-Kees

-- 
Kees Cook
Chrome OS Security
