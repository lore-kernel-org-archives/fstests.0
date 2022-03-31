Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3185C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Mar 2022 09:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiCaJCp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Mar 2022 05:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiCaJCo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Mar 2022 05:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243F4532E8
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 02:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9773618F5
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 09:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018DBC340EE;
        Thu, 31 Mar 2022 09:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648717256;
        bh=9VN+4RbIOA9V1ONCVw83RuExXyowLrAsQ+NcSczPzSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujkFlY1XG31AxRp+uNE8sexgfgDYONlUFcYILSqvC1o4YRTl6caT/NN5vhnEQngXA
         d2rzGJu7gfvjpOdhbSmKJI9oUEIK6xIv8PmkX4URtbFqdGygcydVmEIMgBXkeuYi09
         eCiVIlvwkBeX1Mreo2nCCWO0rYZ+lxjYMJOqZzkzgsHCbHrumWL9Zunmoah/w8RGoF
         B5EePtIH4G8JIlENpwwvt1R3QdevNGNZeg4agPR8/HzgLSK4ijvUUI79NMhQRJZ84M
         7Q5o/1X3WDKGj3TLyjL8TC6Tdp2eJGZE1oMSUCPeqmpBK6eScsVN3mCnGpqGG3pWEs
         zKwRxZp8mlRrQ==
Date:   Thu, 31 Mar 2022 11:00:51 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        fstests@vger.kernel.org
Subject: Re: generic/633 failing without CONFIG_USER_NS
Message-ID: <20220331090051.jwrttmkol6wlv272@wittgenstein>
References: <20220331082846.b4vccc3rb7lmojxs@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220331082846.b4vccc3rb7lmojxs@quack3.lan>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 31, 2022 at 10:28:46AM +0200, Jan Kara wrote:
> Hello,
> 
> I have noticed that when I build a kernel without CONFIG_USER_NS,
> generic/633 is failing. This is because despite it properly detects
> idmapped mounts are not supported, it still tries to execute some tests
> (such as fscaps test) and they rely on bits of user namespace support (e.g.
> /proc/<pid>/ns/user existing). I could hack some additional support check
> into the test but then I figured I'm not sure whether all the tests are OK
> to skip without CONFIG_USER_NS or whether there are not some more subtle
> dependencies... So I'm asking here :).

Hey Jan,

Thank your for detecting and reporting this. So the only ones we can
reasonably run are the ones that don't require idmapped mount support
and of this the actual subset that should be runnable without userns is:

{ hardlink_crossing_mounts,					false,	"cross mount hardlink",										},
{ io_uring,							false,	"io_uring",											},
{ protected_symlinks,						false,	"following protected symlinks on regular mounts",						},
{ rename_crossing_mounts,					false,	"cross mount rename",										},
{ setattr_truncate,						false,	"setattr truncate",										},
{ setgid_create,						false,	"create operations in directories with setgid bit set",						},
{ setid_binaries,						false,	"setid binaries on regular mounts",								},
{ sticky_bit_unlink,						false,	"sticky bit unlink operations on regular mounts",						},
{ sticky_bit_rename,						false,	"sticky bit rename operations on regular mounts",						},
{ symlink_regular_mounts,					false,	"symlink from regular mounts",									},

I think currently we're doing:

struct t_idmapped_mounts {
	int (*test)(void);
	bool require_fs_allow_idmap;
	const char *description;
};

which defines
bool require_fs_allow_idmap
which gets set for each test and then we can skip or execute tests
depending on whether or not they require that.

One possible way to deal with the userns thing in there might be to make
this a flags argument:

unsigned int required_flags;

then

#define T_REQUIRE_IDMAPPED_MOUNTS (0 << 1)
#define T_REQUIRE_USERNS (0 << 2)

then for each test that currently does set require_fs_allow_idmap to
be true we set:

T_REQUIRE_IDMAPPED_MOUNTS

and for the tests that require userns do

T_REQUIRE_USERNS

and 0 for the others. Then in

run_test() we can do:

if (t->required_flags != (t_available_flags & t->required_flags)) {
	log_debug("Skipping test %s", t->description);
	continue;
}

?

Maybe there's a simpler way though. :)

Christian
