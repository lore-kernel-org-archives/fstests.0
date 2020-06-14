Return-Path: <SRS0=StvD=73=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91764C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Jun 2020 20:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59788206B7
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Jun 2020 20:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zl3YWlIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgFNUFe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:05:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51482 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726921AbgFNUFd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Jun 2020 16:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592165130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=qjL/L2ni4GZxP3182FnVyRhzy31b86RZY1x94vrkIb0=;
        b=Zl3YWlICvMO/Ql6co65SqoogNlCeGnDAJ7CwmA8zh9Pmh/VsKw+OzIhJwdYylkMOcNMvKP
        GF/FpVemD9apFulT+jgxbDciPxN6nOILj5LIxYgNTI+M0+NyoIk02U5rPcRndIs+7iUUzQ
        NIjAm7JdgW0Eh/kn4a0lS9WPGvF08tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-dhQdHdIkMVCt6AdlWqMlaA-1; Sun, 14 Jun 2020 16:05:28 -0400
X-MC-Unique: dhQdHdIkMVCt6AdlWqMlaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6BFD1883600
        for <fstests@vger.kernel.org>; Sun, 14 Jun 2020 20:05:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 513035D9C9;
        Sun, 14 Jun 2020 20:05:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
cc:     dhowells@redhat.com
Subject: Making xfstests work with the in-kernel AFS filesystem
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <172371.1592165126.1@warthog.procyon.org.uk>
Date:   Sun, 14 Jun 2020 21:05:26 +0100
Message-ID: <172372.1592165126@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

I've been working on making it possible to use xfstests with the in-kernel AFS
filesystem.  With a few kernel patches, I've got it down to 17 failing tests
from -g quick.

Most of the remaining tests fall into a couple of classes and I wonder what
the best way to handle them is:

 (1) Features that AFS doesn't support - such as ctime, device files and
     fifos.  I have managed to emulate ctime in the fs driver, but that leaves
     mknod and mkfifo.

     I've tried to modify generic/294 along the lines of generic/050 so that
     it can have different comparison data depending on whether mknod exists
     or not, but I can't get it to work.  I've supplied a cfg file and an
     alternate verified output file, but now it just says "no qualified
     output" and does nothing.  I can't see how it's meant to work, and README
     and the stuff in doc/ doesn't help.

     Should I split tests into two where, say, one part does things on regular
     files, dirs and symlinks and the other does things on more exotic types,
     such as fifos.  generic/423 is a prime example of this.

 (2) Differences in security model.  Access to AFS is governed primarily by
     the kerberos ticket in your keyring and is evaluated on the server (which
     gives you a permissions mask that you can cache) - and not by what your
     process uid/gid/grouplist say compared to the uid/gid on the file and
     most of the mode bits are ignored as well.

Any thoughts on this?  Should I add more _require_xxx macros for all of these
things?

Also, would there be interest in patches to automate some of this from the
fsinfo() syscall I've proposed which allows the filesystem indicate its
capabilities?

David

