Name:           pick
Version:        4.0.0
Release:        1%{?dist}
Summary:        A fuzzy search tool for the command-line

License:        MIT
URL:            https://github.com/mptre/pick
Source0:        https://github.com/mptre/pick/archive/v4.0.0.tar.gz

BuildRequires:  gcc make ncurses-devel
#Requires:       curses

%description
Pick is a fuzzy search tool for the command-line.  Pick reads a list of choices from stdin and outputs the selected choice to stdout. Therefore it is easily used both in pipelines and subshells.  Pick can also be used from within Vim, see the pick.vim plugin.

%define debug_package %{nil}

%prep
%autosetup


%build
PREFIX=/usr %_configure
%make_build


%install
rm -rf $RPM_BUILD_ROOT
%make_install
mkdir -p $RPM_BUILD_ROOT/usr/share/man/man1
mv $RPM_BUILD_ROOT/usr/man/man1/pick.1 $RPM_BUILD_ROOT/usr/share/man/man1/pick.1
rm -rf $RPM_BUILD_ROOT/usr/man


%files
%license LICENSE
%doc README.md
%{_bindir}/%{name}
%{_mandir}/man1/pick.1.gz


%changelog
* Mon Apr 27 2020 Benjamin Porter <FreedomBen@users.noreply.github.com>
- 
