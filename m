Received: from mail-yw1-f66.google.com ([209.85.161.66]:39238 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfGXPtN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Jul 2019 11:49:13 -0400
Received: by mail-yw1-f66.google.com with SMTP id x74so279162ywx.6
        for <fstests@vger.kernel.org>; Wed, 24 Jul 2019 08:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190724145511.1155-1-jlayton@kernel.org>
In-Reply-To: <20190724145511.1155-1-jlayton@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 24 Jul 2019 18:49:00 +0300
Message-ID: <CAOQ4uxiiTPxmGWxygbsDMVShBt89qdoBGByeVa2KOwPqSh70SQ@mail.gmail.com>
Subject: Re: [PATCH] generic/062: more restrictive namespace for getfattr on cephfs
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 24, 2019 at 5:55 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> cephfs exposes some information via virtual xattrs and their presence
> causes this test to fail. When running on cephfs, only search for
> specific xattr classes to ensure that we skip the ceph.* ones.
>

Probably too late to ask this question now anyway, but does ceph have
a particular good reason to expose those virt xattr in listxattr?

I means its not xattrs that copy tools should try to copy and tools
should know about them and can try to getxattr without the need
to see them in listxattr.

I noticed this is the behavior of cifs w.r.t cifs. and smb3. virt xattr.

Thanks,
Amir.
